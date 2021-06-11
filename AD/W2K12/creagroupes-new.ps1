# script écrit par  Knight75
Import-Module ActiveDirectory
$groupsn1f = "$gtxtdir\groupsn1f.txt"
$groupsn3f = "$gtxtdir\groupsn3f.txt"
$groupsn4f = "$gtxtdir\groupsn4f.txt"
$groupsn5f = "$gtxtdir\groupsn5f.txt"
$groupsn6f = "$gtxtdir\groupsn6f.txt"
$domaine= "dc=ORG,dc=fr"
$grpScope = "global"
$gc1f= Get-Content $groupsn1f
$gc3f= Get-Content $groupsn3f
$gc4f= Get-Content $groupsn4f
$gc5f= Get-Content $groupsn5f
$gc6f= Get-Content $groupsn6f
$path= "ou=Auto,OU=Groupes,$domaine"

#création des groupes auto OU*

$gc1f | foreach-object { 
     New-ADGroup -name $_ -Description "Tous members $_" -GroupScope $grpScope  -Path $path 
       }

$gc3f | foreach-object { 
     New-ADGroup -name $_ -Description "Tous members $_" -GroupScope $grpScope  -Path "OU=Groupes,OU=OU$i,$domaine" 
       }
       
$gc4f | foreach-object { 
     New-ADGroup -name $_ -Description "Tous members $_" -GroupScope $grpScope  -Path $path 
              }
$gc5f | foreach-object { 
     New-ADGroup -name $_ -Description "Tous members $_" -GroupScope $grpScope  -Path "OU=Groupes,OU=OU$i,$domaine" 
       }
$gc6f | foreach-object { 
     New-ADGroup -name $_ -Description "Tous members $_" -GroupScope $grpScope  -Path "OU=Groupes,OU=OU$i,$domaine" 
       }

      