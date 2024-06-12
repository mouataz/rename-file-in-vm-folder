Import-Module VMware.VimAutomation.Core

# Connect to vCenter Server
$vcenter = "10.10.200.100"
Connect-VIServer -Server $vcenter

# Get cluster
$clusterName = "CL-PROD-01"

# Get datastores for cluster
$datastores = Get-Cluster -Name $clusterName | Get-Datastore


foreach ($datastore in $datastores) {
    # Get VMs by Datastore 
    $datastoreName = $datastore.Name
    $vms = Get-datastore -Name $datastoreName | Get-VM

    foreach ($vm in $vms) {
        # Rename file
        ls "vmstores:\$vcenter@443\DC-PARIS\$datastoreName\$vm" | rename-item -newname {$_.Name -replace "\.db$", ".db.bak"} 

    }
}

Disconnect-VIServer -Server $vcenter -Confirm:$false
