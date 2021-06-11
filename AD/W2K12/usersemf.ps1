
$users = get-content $userfile

foreach ($user in $users){
    
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



foreach ($user in $users){
    
    $adUser = Get-ADUser $user -Properties * 
    $departments = $adUser.Department
    $departments = $departments.Split($separator)[0,1] -join "." -replace "OU","" -replace "OUC",""
    $departments = "auto.$departments"

foreach ($department in $departments){
    Write-Host "ajout de $user à $department"
    Add-ADGroupMember $department $user
            
}
}

foreach ($user in $users){
    
    $adUser = Get-ADUser $user -Properties * 
    $departments = $adUser.Department
    $departments = $departments.Split($separator)[0,1,2] -join "." -replace "OU","" -replace "OUC",""
    $departments = "auto.$departments"

foreach ($department in $departments){
    Write-Host "ajout de $user à $department"
    Add-ADGroupMember $department $user
            
}
}

foreach ($user in $users){
    
    $adUser = Get-ADUser $user -Properties * 
    $departments = $adUser.Department
    $departments = $departments.Split($separator)[0,1] -join "." -replace "OU","" -replace "OUC",""
    $departments = "auto.$departments"

foreach ($department in $departments){
    Write-Host "ajout de $user à $department"
    Add-ADGroupMember $department $user
            
}
}

foreach ($user in $users){
    
    $adUser = Get-ADUser $user -Properties * 
    $departments = $adUser.Department
    $departments = $departments.Split($separator)[0,1,2,3] -join "." -replace "OU","" -replace "OUC",""
    $departments = "auto.$departments"

foreach ($department in $departments){
    Write-Host "ajout de $user à $department"
    Add-ADGroupMember $department $user
            
}
}


sleep 10

foreach ($user in $users){
    
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