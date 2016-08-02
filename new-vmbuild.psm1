function new-vmbuild {

    param(
        [string[]]$name                    # The empty [] means multiple values can be passed into the parameter
    )

    $VMs = $name

    foreach ($vm in $vms) {

        write-host "Creating $vm..."
        new-vm -Name $vm -MemoryStartupBytes 2GB -SwitchName 'VM External Network' -Generation 2 -NewVHDSizeBytes 40GB -NewVHDPath "C:\Users\Public\Documents\Hyper-V\Virtual Hard Disks\$vm\$vm.vhdx" -Path "C:\ProgramData\Microsoft\Windows\Hyper-V\$vm\"
        Add-VMDvdDrive $vm -Path "C:\Users\edwar\Documents\ISOs\Server 2012 R2 x64.ISO"
        $dvd = Get-VMDvdDrive $vm
        $hdd = Get-VMHardDiskDrive $vm
        $network = Get-VMNetworkAdapter $vm
        
        # Comment below out for generation 1 VM
        Set-VMFirmware $vm -BootOrder $hdd, $dvd, $network
        #write-host "Starting $vm...."
        #Start-VM $vm

    }

}

