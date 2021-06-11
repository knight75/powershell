# script écrit par  Knight75
Import-Module ActiveDirectory
$groupsn1f = "$gtxtdir\groupsn1f.txt"
$groupsn2f = "$gtxtdir\groupsn2f.txt"
$groupsn3f = "$gtxtdir\groupsn3f.txt"
$groupsn4f = "$gtxtdir\groupsn4f.txt"
$groupsn5f = "$gtxtdir\groupsn5f.txt"
$groupsn6f = "$gtxtdir\groupsn6f.txt"
$domaine= "dc=lab,dc=ORG,dc=fr"
$patter = "ce","idf","est","ouest","med","so","nc","np"
$pattec = "emf","itm","tv"
$patsie = "siège"
$grpScope = "global"
$gc1f= Get-Content $groupsn1f
$gc2f= Get-Content $groupsn2f
$gc3f= Get-Content $groupsn3f
$gc4f= Get-Content $groupsn4f
$gc5f= Get-Content $groupsn5f
$gc6f= Get-Content $groupsn6f

#création des groupes auto OU*

foreach ($i in $patter) {
 $gc1f| foreach-object { 
     if ($_ -match "auto.$i") { New-ADGroup -name $_ -Description "Tous members $_" -GroupScope $grpScope  -Path "OU=Groupes,OU=OU$i,$domaine" } 
       }
$gc2f | foreach-object { 
     if ($_ -match "auto.$i") { New-ADGroup -name $_ -Description "Tous members $_" -GroupScope $grpScope  -Path "OU=Groupes,OU=OU$i,$domaine" } 
       }
$gc3f | foreach-object { 
     if ($_ -match "auto.$i") { New-ADGroup -name $_ -Description "Tous members $_" -GroupScope $grpScope  -Path "OU=Groupes,OU=OU$i,$domaine" } 
       }
       
$gc4f | foreach-object { 
     if ($_ -match "auto.$i") { New-ADGroup -name $_ -Description "Tous members $_" -GroupScope $grpScope  -Path "OU=Groupes,OU=OU$i,$domaine" } 
              }
$gc5f | foreach-object { 
     if ($_ -match "auto.$i") { New-ADGroup -name $_ -Description "Tous members $_" -GroupScope $grpScope  -Path "OU=Groupes,OU=OU$i,$domaine" } 
       }
$gc6f | foreach-object { 
     if ($_ -match "auto.$i") { New-ADGroup -name $_ -Description "Tous members $_" -GroupScope $grpScope  -Path "OU=Groupes,OU=OU$i,$domaine" } 
       }

       }
       
sleep 20

# création des groupes auto OUC*

foreach ($i in $pattec) {
$gc1f | foreach-object { 
     if ($_ -match "auto.$i") { New-ADGroup -name $_ -Description "Tous members $_" -GroupScope $grpScope  -Path "OU=Groupes,OU=OUC$i,$domaine" } 
       }
$gc2f | foreach-object { 
     if ($_ -match "auto.$i") { New-ADGroup -name $_ -Description "Tous members $_" -GroupScope $grpScope  -Path "OU=Groupes,OU=OUC$i,$domaine" } 
       }
$gc3f | foreach-object { 
     if ($_ -match "auto.$i") { New-ADGroup -name $_ -Description "Tous members $_" -GroupScope $grpScope  -Path "OU=Groupes,OU=OUC$i,$domaine" } 
       }
$gc4f | foreach-object { 
     if ($_ -match "auto.$i") { New-ADGroup -name $_ -Description "Tous members $_" -GroupScope $grpScope  -Path "OU=Groupes,OU=OUC$i,$domaine" } 
              }
$gc5f | foreach-object { 
     if ($_ -match "auto.$i") { New-ADGroup -name $_ -Description "Tous members $_" -GroupScope $grpScope  -Path "OU=Groupes,OU=OUC$i,$domaine" } 
       }
$gc6f | foreach-object { 
     if ($_ -match "auto.$i") { New-ADGroup -name $_ -Description "Tous members $_" -GroupScope $grpScope  -Path "OU=Groupes,OU=OUC$i,$domaine" } 
       }
       }

sleep 20


# création des groupes auto siege

foreach ($i in $patsie) {
$gc1f | foreach-object { 
     if ($_ -match "auto.$i") { New-ADGroup -name $_ -Description "Tous members $_" -GroupScope $grpScope  -Path "OU=Groupes,OU=$i,$domaine" } 
       }
$gc2f | foreach-object { 
     if ($_ -match "auto.$i") { New-ADGroup -name $_ -Description "Tous members $_" -GroupScope $grpScope  -Path "OU=Groupes,OU=$i,$domaine" } 
       }
$gc3f | foreach-object { 
     if ($_ -match "auto.$i") { New-ADGroup -name $_ -Description "Tous members $_" -GroupScope $grpScope  -Path "OU=Groupes,OU=$i,$domaine" } 
       }
$gc4f | foreach-object { 
     if ($_ -match "auto.$i") { New-ADGroup -name $_ -Description "Tous members $_" -GroupScope $grpScope  -Path "OU=Groupes,OU=$i,$domaine" } 
              }
$gc5f | foreach-object { 
     if ($_ -match "auto.$i") { New-ADGroup -name $_ -Description "Tous members $_" -GroupScope $grpScope  -Path "OU=Groupes,OU=$i,$domaine" } 
       }
$gc6f | foreach-object { 
     if ($_ -match "auto.$i") { New-ADGroup -name $_ -Description "Tous members $_" -GroupScope $grpScope  -Path "OU=Groupes,OU=$i,$domaine" } 
       }
       }
       