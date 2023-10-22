$location = $(Invoke-Command {Get-Location}).ToString()
$drive = $($location)[0..1] -join ''
$user = $env:USERPROFILE
$username = $env:USERNAME

Import-Module "$($location)/scraping.psm1"
Import-Module "$($location)/install.psm1"
Import-Module "$($location)/setup.psm1"

cd "$($drive)\Program Files\Oracle\VirtualBox"

$setting = $args[0]

if($setting -ne "setup" -And $setting -ne "os" -And $setting -ne "config"){
  Write-Host "
./visual.ps1 
  help: user manual
  setup: setup pfsense
  "
}elseif($setting -eq "setup"){
  $file_check = Read-Host "Do you have pfsense iso file install? (y/n)"
  if($file_check -ne "y" -And $file_check -ne "n"){
    Write-Host "Invalid action"
  }elseif($file_check -eq "y"){
    $next_step = Read-Host "Do you want to re-install? (y/n)"
    if($next_step -ne "y" -And $next_step -ne "n"){
      Write-Host "Invalid action"
    }elseif($next_step -eq "y"){
      $lab_number = Read-Host "Lab number"
      $version = Get-Version
      Install-App $verion $location
      $MediaPath = "$($location)/mnt/pfSense-CE-$($version)-RELEASE-amd64.iso"
      Set-Up $lab_number $MediaPath
    }else{
      $lab_number = Read-Host "Lab number"
      $MediaPath = Read-Host "Path to your OpenWRT image"
      Set-Up $lab_number $MediaPath
    }
  }else{
      $lab_number = Read-Host "Lab number"
      $version = Get-Version
      Install-App $verion $location
      $MediaPath = "$($location)/mnt/pfSense-CE-$($version)-RELEASE-amd64.iso"
      Set-Up $lab_number $MediaPath
  }
}elseif($setting -eq "config"){
  # config pfsense
}



cd "$($location)"

