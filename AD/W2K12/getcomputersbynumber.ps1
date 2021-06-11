Import-Module activedirectory
$ctxtdir = "D:\scripts\divers\inventaire\txts\"
$clist = "$ctxtdir\computers.csv"
$clistbron = "$ctxtdir\listpcbron.csv"
Get-ADComputer -Filter { (name -Like '*f4*-*') -or (name -Like '*p4*-*')} -Properties OperatingSystem | Select Name, OperatingSystem | export-csv -path $clist 
Get-ADComputer -Filter { (name -Like '*f40-*') -or (name -Like '*p40-*')} -Properties OperatingSystem | Select Name, OperatingSystem | export-csv -path $clistbron