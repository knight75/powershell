Import-Module ActiveDirectory
Get-ADGroup -filter {name -like "ce_*.*"}  -Properties Member |
foreach { 
 Write-Host "Exporting $($_.name)" -ForegroundColor Cyan
 $name = $_.name -replace " ","-"
 $file = Join-Path -path "d:\scripts" -ChildPath "$name.csv"
 $_.member | Get-ADObject -Properties SamAccountname,Title,Department |
 Select Name,SamAccountName,Title,Department,DistinguishedName,ObjectClass |
 Export-Csv -Path $file -NoTypeInformation
}