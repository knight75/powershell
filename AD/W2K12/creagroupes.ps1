# script écrit par  Knight75
Import-Module ActiveDirectory
$gtxtdir =  "C:\scripts\gpauto\txts"
$dptfinal = "$gtxtdir\dptfinal.txt"
$dptfinal = "$gtxtdir\dpts.csv"
$tempfile = "$gtxtdir\temp.csv"
$dptfile= "$gtxtdir\groups.txt"

$delimiter1=","
$delimiter2="/"

Get-ADUser -Filter {(enabled -eq "true")} -properties *  | Where-Object {$_.department -ne $null}| select -ExpandProperty department -unique | ConvertTo-Csv -Delimiter $delimiter2 -NoTypeInformation | foreach { $_ -replace '"',''} | out-file $tempfile -fo -en utf8 

 
import-csv $dptfile -delimiter "/" -header Service0,Service1,Service2,Service3,Service4 | export-csv $tempfile -en utf8 -notypeinformation

import-csv $tempfile | foreach { $_.Service0 -replace "OU","auto." -replace "OUC","auto"."" -replace "Siège","auto.Siège"} | export-csv $dptfinal -en utf8 -notypeinformation

import-csv $file -Header a , b , c  | Tee-Object -Variable $filedata | Export-csv $file -NoTypeInformation

$mynewcount= "4"
for($i = 0; $i -lt $mynewcount; $i++){
  get-content $dptfile | Select-Object @{Label = "Service$i";Expression = {($_.Department).Split("$delimiter2")[$i]}} | ConvertTo-Csv -Delimiter $delimiter1 -NoTypeInformation | foreach { $_ -replace '"',''} | out-file $txtfile -fo -en utf8

}


foreach ($i in $unite){
New-ADGroup "G_$i" -GroupScope Global -Path "OU=Groupes,OU=$i,OU=essais,dc=lab,dc=ORG,dc=fr"
}




#$department = get-content $dptfile

#$myNewCount = 0
#foreach ($line in [System.IO.File]::ReadLines("$dptfile")){
#    $fields = $line.Split("$delimiter2").GetUpperBound(0);
#    If ($fields -gt $myNewCount)
#    {$myNewCount = $fields}
#}

#write-host $myNewCount