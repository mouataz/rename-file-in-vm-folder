Import-Module VMware.VimAutomation.Core

# Connect to vCenter Server
$vcenter = "Your vCenter"
Connect-VIServer -Server $vcenter

$datac = "your Datacenter"

# Get cluster
$clusterName = "Your Cluster"

# Get datastores for cluster
$datastores = Get-Cluster -Name $clusterName | Get-Datastore

foreach ($datastore in $datastores) {
    # Get VMs by Datastore 
    $datastoreName = $datastore.Name
    $vms = Get-datastore -Name $datastoreName | Get-VM

    foreach ($vm in $vms) {
        # Rename file
        ls "vmstores:\$vcenter@443\$datac\$datastoreName\$vm" | rename-item -newname {$_.Name -replace "\.db$", ".db.bak"} 

    }
}

Disconnect-VIServer -Server $vcenter -Confirm:$false
