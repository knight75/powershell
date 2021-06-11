#script écrit par  Knight75
import-module activedirectory

#$userslist = Import-CSV "D:\scripts\divers\emptype\Txts\users_siege.csv"

$userslist | %{ Set-ADUser  $_.identifiant -replace @{employeetype="007"} }