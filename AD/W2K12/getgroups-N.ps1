# script écrit par  Knight75
Import-Module ActiveDirectory
$gtxtdir = "D:\scripts\gpauto\txts\groups"
$dptfinal = "$gtxtdir\dptfinal.txt"
$groupn1 = "$gtxtdir\groupn1.txt"
$groupn2 = "$gtxtdir\groupn2.txt"
$groupn3 = "$gtxtdir\groupn3.txt"
$groupn4 = "$gtxtdir\groupn4.txt"
$groupn5 = "$gtxtdir\groupn5.txt"
$groupn6 = "$gtxtdir\groupn6.txt"
$groupsf = "$gtxtdir\groupsf.txt"
$groupse = "$gtxtdir\groupse.txt"
$groupsd = "$gtxtdir\groupsd.txt"
$groupsc = "$gtxtdir\groupsc.txt"
$groupsb = "$gtxtdir\groupsb.txt"
$groupsa = "$gtxtdir\groupsa.txt"


Remove-Item "$gtxtdir\*.*"

#parcours du domaine pour trouver les entrées du champ Department (service en français) pour les users actifs
get-aduser -filter "enabled -eq 'true'" -property department -SearchBase "dc=ORG,dc=fr" | select -ExpandProperty department -Unique > $dptfinal

#création de la liste des groupes de niveau 1
Get-Content $dptfinal | ForEach-Object {
    $_.split("/")[0] -replace "OU","" -replace "OUC","" -replace "emf","" -replace "itm",""
    } |sort -unique > $groupn1


Get-Content $dptfinal | Where-Object { $_.split("/").length -eq 2} | ForEach-Object {
     $_.split("/") -join '.' -replace "OU","" -replace "OUC",""
    } |sort -unique > $groupn2


Get-Content $dptfinal | ForEach-Object {
    $_ -replace "/","." `
       -replace "OU","" `
       -replace "OUC",""
    } |sort -unique > $groupn3

Get-Content $dptfinal | Where-Object { $_.split("/").length -eq 4} | ForEach-Object {
     $_.split("/") -join '.' -replace "OU","" -replace "OUC",""
    } |sort -unique > $groupn4

Get-Content $dptfinal | Where-Object { $_.split("/").length -eq 3} | ForEach-Object {
     $_.split("/") -join '.' -replace "OU","" -replace "OUC",""
    } |sort -unique > $groupn5

Get-Content $dptfinal | ForEach-Object {
     $_.split("/")[0,1] -join '.' -replace "OU","" -replace "OUC",""
    } |sort -unique > $groupn6

Get-Content $groupn1 | where { $_ -ne "$null" } | ForEach-Object {
        Add-Content $groupsd "auto.$_"
    }


Get-Content $groupn2 | ForEach-Object {
        Add-Content $groupse "auto.$_-base"
    }

Get-Content $groupn3 | ForEach-Object {
        Add-Content $groupsf "auto.$_"
    }

Get-Content $groupn4 | ForEach-Object {
        Add-Content $groupsc "auto.$_-base"
    }
Get-Content $groupn5 | ForEach-Object {
        Add-Content $groupsb "auto.$_-base"
    }
Get-Content $groupn6 | ForEach-Object {
        Add-Content $groupsa "auto.$_"
    }




