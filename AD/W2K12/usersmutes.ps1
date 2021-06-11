# script écrit par  Knight75
Import-Module ActiveDirectory
$utxtdir = "D:\scripts\gpauto\txts\users"
$logdir = "D:\scripts\gpauto\logs"
$separator = "/"
$When = ((Get-Date).AddHours(-2))
Get-ChildItem -Path $utxtdir | where {$_.Attributes -ne "Directory"} | ForEach-Object {
    move-Item -Path $_.FullName -Destination "$logdir\$($_.BaseName,(Get-Date).ToString("MMddyyyy-HHmm"))"
}
$usermutes = "$utxtdir\usersmute.txt"
Get-ADUser -Filter {(enabled -eq "true") -and (whenchanged -ge $When) } -Properties whenChanged| select -ExpandProperty samaccountname > $usermutes
$login = get-content $usermutes
$gtxtdir = "D:\scripts\gpauto\txts\groups"
$groupsfile = "$gtxtdir\listgroupauto.txt"

foreach ($user in $login){
    
    $adUser = Get-ADUser $user -Properties * 
    $departments = $adUser.Department
    $departments = $departments.Split($separator)[0] -join "." -replace "OU","" -replace "OUC",""
    $departments = "auto.$departments"

foreach ($department in $departments){
    Write-Host "ajout de $user à $department"
    Add-ADGroupMember $department $user
    $groupMember = (Get-ADGroupMember $department).Name
        
}
}

foreach ($user in $login){
    
    $adUser = Get-ADUser $user -Properties * 
    $departments = $adUser.Department
    $departments = $departments.Split($separator)[0,1] -join "." -replace "OU","" -replace "OUC",""
    $departments = "auto.$departments"

foreach ($department in $departments){
    Write-Host "ajout de $user à $department"
    Add-ADGroupMember $department $user
            
}
}

foreach ($user in $login){
    
    $adUser = Get-ADUser $user -Properties * 
    $departments = $adUser.Department
    $departments = $departments.Split($separator)[0,1,2] -join "." -replace "OU","" -replace "OUC",""
    $departments = "auto.$departments"

foreach ($department in $departments){
    Write-Host "ajout de $user à $department"
    Add-ADGroupMember $department $user
            
}
}

foreach ($user in $login){
    
    $adUser = Get-ADUser $user -Properties * 
    $departments = $adUser.Department
    $departments = $departments.Split($separator) -join "." -replace "OU","" -replace "OUC",""
    $departments = "auto.$departments-entite"

foreach ($department in $departments){

if ( select-string $department $groupsfile) {
    Write-Host "ajout de $user à $department"
    Add-ADGroupMember $department $user
}
else 
{ "pas de $department pour $user"}
        }
}
