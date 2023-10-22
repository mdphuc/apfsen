Function Set-Up($lab_number, $MediaPath){
    $lab_number = $args[0]
    $MediaPath = $args[1]
    try{    
        $VMNum = $(Invoke-Command {.\VBoxManage.exe list vms}).Length
        try{
            Invoke-Command {.\VBoxManage.exe createvm --name pfsense --ostype $OSType --register}
            Invoke-Command {.\VBoxManage.exe modifyvm pfsense --groups "/Lab$($lab_number)/Router"}
            Invoke-Command {.\VBoxManage.exe modifyvm pfsense --cpus $CPU --memory 512 --vram 12} 
            Invoke-Command {.\VBoxManage.exe modifyvm pfsense --graphicscontroller vmsvga}
            Invoke-Command {.\VBoxManage.exe createhd --filename "$($env:USERPROFILE)\VirtualBox VMs\Lab$($lab_number)\Router\pfsense\pfsense.vdi" --size $Size --variant Standard}
            Invoke-Command {.\VBoxManage.exe storagectl pfsense --name "SATA Controller $($VMNum)" --add sata --bootable on}
            Invoke-Command {.\VBoxManage.exe storageattach pfsense --storagectl "SATA Controller $($VMNum)" --port 0 --device 0 --type hdd --medium "$($env:USERPROFILE)\VirtualBox VMs\Lab$($lab_number)\Router\pfsense\pfsense.vdi"} 
            Invoke-Command {.\VBoxManage.exe storagectl pfsense --name "IDE Controller $($VMNum)" --add ide}
            # Invoke-Command {.\VBoxManage.exe storageattach pfsense --storagectl "IDE Controller $($VMNum)" --port 0 --device 0 --type dvddrive --medium $MediaPath}
            Invoke-Command {.\VBoxManage.exe unattended install pfsense --iso=$MediaPath}
            Write-Host "Successfully create virtual machine named pfsense"
        }catch{
            Write-Host $_
        }
    }
}


