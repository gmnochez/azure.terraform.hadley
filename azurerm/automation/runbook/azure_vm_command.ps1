# -------------------------------
# 2. Parameters
# -------------------------------

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

# -------------------------------
# 3. Main Script Logic
# -------------------------------

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
            $result = Invoke-AzVMRunCommand -ResourceGroupName $rgn_vm -Name $VM.Name -CommandId $commandType -ScriptString $vm_command
            Write-Output $result.value.Message  

        }
        catch {
            $ErrorMessage = $_.Exception.Message
            Write-Error "Error starting the VM $($VM.Name): $ErrorMessage"
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
            Write-Error "Error stopping the VM $($VM.Name): $ErrorMessage"
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






