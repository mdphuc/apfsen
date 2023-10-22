Function Get-Version{
  $scraped_links = Invoke-WebRequest -Uri 'https://docs.netgate.com/pfsense/en/latest/releases/index.html'
  $responses = $scraped_links.ParsedHtml.getElementsByTagName('div') | where id -eq "pfsense-ce-software" 
  $response = $responses.innerHTML.ToString() -split([Environment]::NewLine)
  $response = $response[3].SubString(69,5)
  return $response
}
