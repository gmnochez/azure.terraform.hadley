<#
.SYNOPSIS
 Script to start or stop Azure VMs with Azure Automation. 
.DESCRIPTION
 This script is intended to start or stop Azure Virtual Machines in a simple way in Azure Automation.
 The script uses Azure Automation Managed Identity and the modern ("Az") Azure PowerShell Module.
    
 Requirements:
 Give the Azure Automation Managed Identity necessary rights to Start/Stop VMs in the Resource Group.
 You can create a custom role for this purpose with the following permissions: 
   - Microsoft.Compute/virtualMachines/deallocate/action
   - Microsoft.Compute/virtualMachines/start/action
   - Microsoft.Compute/virtualMachines/read
.NOTES
  Version:        1.2.0
  Author:         Andreas Dieckmann
  Creation Date:  2022-03-11
  GitHub:         https://github.com/diecknet/Simple-Azure-VM-Start-Stop
  Blog:           https://diecknet.de
  License:        MIT License
  Copyright (c) 2022 Andreas Dieckmann
  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:
  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
  
.LINK 
  https://diecknet.de/
.LINK
  https://github.com/diecknet/Simple-Azure-VM-Start-Stop
.INPUTS
    None
.OUTPUTS
    String to determine result of the script executed
#>



param(
    [Parameter(Mandatory = $true)]
    # Specify the name of the Virtual Machine, or use the asterisk symbol "*" to affect all VMs in the resource group
    $vm_name,
    [Parameter(Mandatory = $true)]
    $vm_command,
    [Parameter(Mandatory = $true)]
    $rgn_vm,
    [Parameter(Mandatory = $false)]
    # Optionally specify Azure Subscription ID
    $azure_subscription_id,
    [Parameter(Mandatory = $true)]
    [ValidateSet("Start", "Stop")]
    # Specify desired Action, allowed values "Start" or "Stop"
    $action_script
)



Write-Output $vm_name, $vm_command, $rgn_vm, $azure_subscription_id, $action_script
Write-Output "Script started at $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"

$errorCount = 0

# connect to Azure, suppress output
try {
    Write-Output "Connecting...."
    $null = Connect-AzAccount -Identity
}
catch {
    $ErrorMessage = "Error connecting to Azure: " + $_.Exception.message
    Write-Error $ErrorMessage
    throw $ErrorMessage
    exit
}

# select Azure subscription by ID if specified, suppress output
if ($azure_subscription_id) {
    try {
        $null = Select-AzSubscription -SubscriptionID $azure_subscription_id
        Write-Output "Assign Subscription"    
    }
    catch {
        $ErrorMessage = "Error selecting Azure Subscription ($azure_subscription_id): " + $_.Exception.message
        Write-Error $ErrorMessage
        throw $ErrorMessage
        exit
    }
}

# check if we are in an Azure Context
try {
    $AzContext = Get-AzContext
    Write-Output "Get Context ......"
}
catch {
    $ErrorMessage = "Error while trying to retrieve the Azure Context: " + $_.Exception.message
    Write-Error $ErrorMessage
    throw $ErrorMessage
    exit
}
if ([string]::IsNullOrEmpty($AzContext.Subscription)) {
    $ErrorMessage = "Error. Didn't find any Azure Context. Have you assigned the permissions according to 'CustomRoleDefinition.json' to the Managed Identity?"
    Write-Error $ErrorMessage
    throw $ErrorMessage
    exit
}


try {
    # get only the specified VM
    $VM = Get-AzVM -ResourceGroupName $rgn_vm -Name $vm_name
    Write-Output "Getting VM....  $($VM.Name)"
}
catch {
    $ErrorMessage = "Error getting VM ($vm_name) from resource group ($rgn_vm): " + $_.Exception.message
    Write-Error $ErrorMessage
    throw $ErrorMessage
    exit
}



Write-Output "Applying $action_script in the vm $vm_name ...."

try {
    # Determine OS
    $osType = $VM.StorageProfile.OSDisk.OSType.ToString()
    Write-Output "Detected OS type: $osType"

    # Decide CommandId
    if ($osType -eq "Windows") {
        $commandType = "RunPowerShellScript"
    } elseif ($osType -eq "Linux") {
        $commandType = "RunShellScript"
    } else {
        throw "Unknown OS type: $osType"
    }


}
catch {
    throw "Failed to get the OS type from VM: $($_.Exception.Message)"
}

try {
    # Get VM with status
    $vmStatus = Get-AzVM -ResourceGroupName $rgn_vm -Name $vm_name -Status
    # Extract power state
    $powerState = ($vmStatus.Statuses | Where-Object { $_.Code -like 'PowerState/*' }).DisplayStatus
}catch {
    Write-Error "Error processing VM '$vm_name': $($_.Exception.Message)"
}

Get-AzVMRunCommand -ResourceGroupName $rgn_vm -VMName $vm_name

switch ($action_script) {
    "Start" {
        # Start the VM
        try {
            if ($powerState -eq 'VM running') {
                Write-Output "VM '$vm_name' is already running. No action needed."
            } else {
                Write-Output "Starting VM $($VM.Name)..."
                $null = $VM | Start-AzVM -ErrorAction Stop -NoWait
            }
            
            Write-Output "Executing command in VM : $vm_command..."
            #$result = Invoke-AzVMRunCommand -ResourceGroupName $rgn_vm -Name $VM.Name -CommandId $commandType -ScriptString $vm_command
            
            $result = Invoke-VMRunCommandWithRetry -ResourceGroupName $rgn_vm -VMName $vm_name -CommandId $commandType -ScriptString @($vm_command) -MaxRetries 5 -DelaySeconds 10
            Write-Output $result.value.Message    
        }
        catch {
            $ErrorMessage = $_.Exception.Message
            Write-Error "Error starting the VM $($VM.Name): " + $ErrorMessage
            # increase error count
            $errorCount++
            Break
        }
    }
    "Stop" {
        # Stop the VM
        try {
            if ($powerState -eq 'VM running') {
                Write-Output "Executing command in VM : $vm_command..."
                $result = Invoke-AzVMRunCommand -ResourceGroupName $rgn_vm -Name $VM.Name -CommandId $commandType -ScriptString $vm_command
                Write-Output $result.value.Message  
                Write-Output "Stopping VM $($VM.Name)..."
                $null = $VM | Stop-AzVM -ErrorAction Stop -Force -NoWait
                
            } else {
                Write-Output "VM '$vm_name' is already stopped. No action needed."
            }
                
        }
        catch {
            $ErrorMessage = $_.Exception.Message
            Write-Error "Error stopping the VM $($VM.Name): " + $ErrorMessage
            # increase error count
            $errorCount++
            Break
        }
    }    
}


$endOfScriptText = "Script ended at $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
if ($errorCount -gt 0) {
    throw "Errors occured: $errorCount `r`n$endofScriptText"
}
Write-Output $endOfScriptText






function Invoke-VMRunCommandWithRetry {
    param (
        [string]$ResourceGroupName,
        [string]$VMName,
        [string]$CommandId,
        [string[]]$ScriptString,
        [int]$MaxRetries = 5,
        [int]$DelaySeconds = 15
    )

    $attempt = 0
    $success = $false
    $lastError = $null

    while (-not $success -and $attempt -lt $MaxRetries) {
        try {
            Write-Output "Attempt $($attempt + 1): Running command '$CommandId' on VM '$VMName'..."
            $result = Invoke-AzVMRunCommand `
                -ResourceGroupName $ResourceGroupName `
                -Name $VMName `
                -CommandId $CommandId `
                -ScriptString $ScriptString `
                -ErrorAction Stop

            Write-Output "Command executed successfully on VM '$VMName'."
            $success = $true
            return $result
        }
        catch {
            $lastError = $_
            if ($_.Exception.Message -like "*Run command extension execution is in progress*") {
                Write-Warning "RunCommand is still in progress on VM '$VMName'. Retrying in $DelaySeconds seconds..."
                Start-Sleep -Seconds $DelaySeconds
                $attempt++
            } else {
                throw $_  # Unexpected error — rethrow
            }
        }
    }

    # If failed after all retries
    throw "Failed to run command on VM '$VMName' after $MaxRetries attempts. Last error: $($lastError.Exception.Message)"
}