# script écrit par  Knight75
Import-Module ActiveDirectory
$logdir= "D:\scripts\gpauto\logs"
$logfile= "$logdir\usersdisabled.txt"
$login = Get-ADUser -Filter {(enabled -eq "false") -and ( name -like "del2*z*" ) } -Properties whenChanged| select -ExpandProperty samaccountname
$d = Get-Date
Move-Item $logfile "$logfile-$(get-date -f yyyy-MM-dd)"
write-output "####################" >> $logfile
write-output "####################" >> $logfile
write-output $d >> $logfile
write-output "####################" >> $logfile
foreach ( $logins in $login ) {
write-output "traitement de $logins" >> $logfile
$oldgroups = Get-ADUser $logins -Properties memberof
$Groups = $oldgroups.memberof
$Groups | Foreach-Object{Get-ADGroup $_ | Remove-ADGroupMember -Member $logins -Confirm:$false}
}
