# script écrit par  Knight75
Import-Module ActiveDirectory
$gtxtdir = "C:\scripts\gpauto\txts\groups\creagr"
$dptfinal = "$gtxtdir\dptfinal.txt"
$groupn = "$gtxtdir\groupn"
$groupn1 = "$gtxtdir\groupn1.txt"
$groupn2 = "$gtxtdir\groupn2.txt"
$groupn3 = "$gtxtdir\groupn3.txt"
$groupn4 = "$gtxtdir\groupn4.txt"
$groupn4temp = "$gtxtdir\groupn4temp.txt"
$groupn5 = "$gtxtdir\groupn5.txt"
$groupn5temp = "$gtxtdir\groupn5temp.txt"
$groupn6 = "$gtxtdir\groupn6.txt"
$groupsn1f = "$gtxtdir\groupsn1f.txt"
$groupsn2f = "$gtxtdir\groupsn2f.txt"
$groupsn3f = "$gtxtdir\groupsn3f.txt"
$groupsn4f = "$gtxtdir\groupsn4f.txt"
$groupsn5f = "$gtxtdir\groupsn5f.txt"
$groupsn6f = "$gtxtdir\groupsn6f.txt"
$manuel = "$gtxtdir\sansdpts.txt"
$domaine= "dc=lab,dc=ORG,dc=fr"
$delimiter="/"
$NewCnt = 0

Remove-Item "$gtxtdir\*.*"

#parcours du domaine pour trouver les entrées du champ Department (service en français) pour les users actifs
get-aduser -filter "enabled -eq 'true'" -property department -SearchBase $domaine | Where-Object {$_.department -ne $null} | select -ExpandProperty department -Unique > $dptfinal

foreach ($line in [System.IO.File]::ReadLines("$dptfinal")){
    $fields = $line.Split("$delimiter").GetUpperBound(0);
    If ($fields -gt $NewCnt)
    {$NewCnt = $fields}
}


write-host $newcnt 

#création de la liste des groupes

Get-Content $dptfinal | where { $_ -ne "$null" } | ForEach-Object {
    $_.split("$delimiter")[0] -replace "OU","" -replace "OUC",""
        } |sort -unique > $groupn1

Get-Content $dptfinal | ForEach-Object {
    $_ -replace "$delimiter","." `
       -replace "OU","" `
       -replace "OUC",""
    } |sort -unique > $groupn3

Get-Content $dptfinal | ForEach-Object {
     $_.split("$delimiter")[0,1] -join '.' -replace "OU","" -replace "OUC",""
    } |sort -unique > $groupn6

Get-Content $dptfinal | Where-Object { $_.split("$delimiter").length -eq 3} | ForEach-Object {
     $_.split("$delimiter") -join '.' -replace "OU","" -replace "OUC",""
    } |sort -unique > $groupn4temp

Get-Content $dptfinal | Where-Object { $_.split("$delimiter").length -eq 4} | ForEach-Object {
     $_.split("$delimiter") -join '.' -replace "OU","" -replace "OUC",""
    } |sort -unique > $groupn5temp

Get-Content $dptfinal | Where-Object { $_.split("$delimiter").length -eq5} | ForEach-Object {
     $_.split("$delimiter") -join '.' -replace "OU","" -replace "OUC",""
    } |sort -unique > $groupn2

Get-Content $groupn4temp | ForEach-Object {
     $_.split(".")[0,1] -join '.' -replace "OU","" -replace "OUC",""
    } |sort -unique > $groupn4

Get-Content $groupn5temp | ForEach-Object {
     $_.split(".")[0..2] -join '.' -replace "OU","" -replace "OUC",""
    } |sort -unique > $groupn5


Get-Content $groupn1 | where { $_ -ne "$null" } | ForEach-Object {
        Add-Content $groupsn1f "auto.$_"
    }

Get-Content $groupn3 | where { $_ -ne "$null" } | ForEach-Object {
        Add-Content $groupsn3f "auto.$_"
    }


Get-Content $groupn6 | where { $_ -ne "$null" } | ForEach-Object {
        Add-Content $groupsn6f "auto.$_"
    }

Get-Content $groupn4 | where { $_ -ne "$null" }  | ForEach-Object {
        Add-Content $groupsn4f "auto.$_-entite"
    }

Get-Content $groupn5 | where { $_ -ne "$null" }  | ForEach-Object {
        Add-Content $groupsn5f "auto.$_-entite"
    }

