Import-Module activedirectory

$txtdir="C:\Users\Public\Documents\"
$txttemp="$txtdir\export-temp.csv"
$txtfile="$txtdir\exportad.csv"

get-aduser -filter {(enabled -eq "true")} -properties * -searchbase "ou=users,ou=OUCE,dc=ORG,dc=fr"  | Select-Object @{Label = "First Name";Expression = {$_.GivenName}},  
                  @{Label = "Last Name";Expression = {$_.Surname}}, 
                  @{Label = "Direction";Expression = {($_.Department).Split("/")[0]  -replace "OU","ORG_"}},
                  @{Label = "Service1";Expression = {($_.Department).split("/")[1]}}, @{Label = "Service2";Expression = {($_.Department).split("/")[2]}}, @{Label = "Service3";Expression = {($_.Department).split("/")[3]}}, @{Label = "Service4";Expression = {($_.Department).split("/")[4]}}  | export-csv -path $txtfile -notypeinformation



$encoding=[System.Text.Encoding]::UTF8
                  send-mailmessage -from "PWSHELL_OUCE <OUCE.Admins@ORG.i2>" -to 'Clement <clement.le-pochat@ORG.fr>', 'Equipe-Exploit-Bron <cete-lyon.exploitation.sg@ORG.fr>' -subject "Export-Active-directory branche OUCE"  -body "Bonjour veuillez trouver en pièce-jointe l'export quotidien AD de la OUCE" -Attachment "$txtfile" -smtpServer "smtp.melanie2.i2" -encoding $encoding
 