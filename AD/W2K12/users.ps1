# script écrit par  Knight75
Import-Module ActiveDirectory
$dir1="D:\scripts\gpauto"
$utxtdir = "$dir1\txts\users"
$separator = "/"
$When = ((Get-Date).AddDays(-1)).Date
$gtxtdir = "$dir1\txts\groups"
$groupsfile = "$gtxtdir\listgroupauto.txt"
$logdir = "$dir1\logs"

Get-ChildItem -Path $utxtdir | where {$_.Attributes -ne "Directory"} | ForEach-Object {
    move-Item -Path $_.FullName -Destination "$logdir\$($_.BaseName,(Get-Date).ToString("MMddyyyy-HHmm"))"
}

if (!(Test-Path $groupsfile)) {
 Get-AdGroup -filter * | Where {$_.name -like "auto.*"} | select name -ExpandProperty name > $groupsfile
 }

$userfile = "$utxtdir\users.txt"
Get-ADUser -Filter {(enabled -eq "true") -and (whenCreated -ge $When) } -Properties * | Where-Object {$_.department -ne $null} | select -ExpandProperty samaccountname > $userfile
$users = get-content $userfile

foreach ($user in $users){
    
    $adUser = Get-ADUser $user -Properties * 
    $department1 = $adUser.Department
    $departments = $department1.Split($separator)[0] -join "." -replace "OU","" -replace "OUC",""
    $departments = "auto.$departments"


if ((Get-ADUser $User -Properties memberof).memberof -like "CN=$departments*")
{
#write-host "$user is already member of $departments"
write-host "$user déjà dans le groupe $departments"
}
Else
{
foreach ($department in $departments){
    Write-Host "ajout de $user à $department"
    Add-ADGroupMember $department $user
    $groupMember = (Get-ADGroupMember $department).Name
        
}
}

    $departments = $department1.Split($separator)[0,1] -join "." -replace "OU","" -replace "OUC",""
    $departments = "auto.$departments"

foreach ($department in $departments){
    Write-Host "ajout de $user à $department"
    Add-ADGroupMember $department $user
            
}

    $departments = $department1.Split($separator)[0,1,2] -join "." -replace "OU","" -replace "OUC",""
    $departments = "auto.$departments"

foreach ($department in $departments){
    Write-Host "ajout de $user à $department"
    Add-ADGroupMember $department $user
            
}
    $departments = $department1.Split($separator)[0,1,2,3] -join "." -replace "OU","" -replace "OUC",""
    $departments = "auto.$departments"

foreach ($department in $departments){
    Write-Host "ajout de $user à $department"
    Add-ADGroupMember $department $user
            
}

    $departments = $department1.Split($separator) -join "." -replace "OU","" -replace "OUC",""
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
