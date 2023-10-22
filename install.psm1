Function Install-App{
  $version = $args[0]
  $location = $args[1]
  Invoke-Command {cp "$($location)/Dockerfile" "$($location)/Dockerfile.bk"}
  Add-Content -Path "$($location)/Dockerfile" -Value "RUN wget 'https://atxfiles.netgate.com/mirror/downloads/pfSense-CE-$($version)-RELEASE-amd64.iso.gz'"
  Add-Content -Path "$($location)/Dockerfile" -Value "RUN gzip pfSense-CE-$($version)-RELEASE-amd64.iso.gz"
  Invoke-Command {docker compose up}
  Invoke-Command {docker run --name apfsen -v "$($location)/mnt":/mnt -itd apfsen-install}
  $id = Invoke-Command {docker container ls --all --quiet --filter "name=apfsen"}
  Invoke-Command {docker exec -it $id sh -c "mv . /mnt/pfSense-CE-$($version)-RELEASE-amd64.iso"}
  Invoke-Command {cp "$($location)/Dockerfile.bk" "$($location)/Dockerfile"}
}