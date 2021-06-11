# script écrit par  Knight75
Import-Module ActiveDirectory
$gtxtdir =  "C:\scripts\gpauto\txts"
$dptfinal = "$gtxtdir\dptfinal.txt"
$groupn1 = "$gtxtdir\groupn1.txt"
$groups2 = "$gtxtdir\group2.txt"
$txtfile= "$gtxtdir\groups.csv"

$delimiter1=","
$delimiter2="/"

function fcount-car ([string]$chaine, [string]$caractere)
{
   for ($car = 0; $car -lt "$chaine".length; $car +=1)
    {
        if ("$chaine".substring($car,1) -eq $caractere)
        {
            $out +=1
        }
    }
    return $out
}



get-aduser -filter {(enabled -eq "true") -and (department -notlike "CPII") } -properties *  | Where-Object {$_.department -ne $null} | Select-Object @{Label = "Service0";Expression = {($_.Department).Split("$delimiter2")[0]  -replace "OU","auto." -replace "OUC","auto." -replace "siège","auto.siège"}},
              @{Label = "Service1";Expression = {($_.Department).split("$delimiter2")[1]}},
              @{Label = "Service2";Expression = {($_.Department).split("$delimiter2")[2]}},
              @{Label = "Service3";Expression = {($_.Department).split("$delimiter2")[3]}},
              @{Label = "Service4";Expression = {($_.Department).split("$delimiter2")[4]}},
              @{Label = "Cn";Expression = {($_.cn)}} | ConvertTo-Csv -Delimiter $delimiter1 -NoTypeInformation | foreach { $_ -replace '"',''} | out-file $txtfile -fo -en utf8

$groups= import-csv $txtfile

