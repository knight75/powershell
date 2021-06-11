Import-module ActiveDirectory

$list= Get-AdGroup -filter * | Where {$_.name -like "auto.*"} 

foreach ($Group in $list) {
    move-adobject -identity $group -targetpath 'ou=auto,ou=groupes,dc=lab,dc=ORG,dc=fr'
}