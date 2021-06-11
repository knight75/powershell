#script écrit par  Knight75
Import-Module activedirectory

$delimiter=","
$txtdir="C:\Users\Public\Documents\"
$txttemp="$txtdir\export-temp.csv"
$txtfile="$txtdir\exportad.csv"

get-aduser -filter {(department -notlike "CPII") -and (department -like "OUCE*") -or (department -like "Siège*")  } -properties * | Where-Object {$_.department -ne $null} |Select-Object @{Label = "Sid";Expression = {$_.sid}}, @{Label = "First Name";Expression = {$_.GivenName}},  
                  @{Label = "Last Name";Expression = {$_.Surname}}, 
                  @{Label = "Mail";Expression = {$_.mail}},
                  @{Label = "Direction";Expression = {($_.Department).Split("/")[0]  -replace "OU","ORG_" -replace "Siège","ORG_Siège"}},
                  @{Label = "Service1";Expression = {($_.Department).split("/")[1]}},
                  @{Label = "Service2";Expression = {($_.Department).split("/")[2]}},
                  @{Label = "Service3";Expression = {($_.Department).split("/")[3]}},
                  @{Label = "Service4";Expression = {($_.Department).split("/")[4]}},
                  @{Label = "Statut (0=Actif)";Expression = {if (($_.Enabled -eq 'TRUE')  ) {'0'} Else {'1'}}}  | ConvertTo-Csv -Delimiter $delimiter -NoTypeInformation | Select-Object -Skip 1| foreach { $_ -replace '"',''} | out-file $txtfile -fo -en utf8


$encoding=[System.Text.Encoding]::UTF8
                  send-mailmessage -from "PWSHELL_OUCE <OUCE.Admins@ORG.i2>" -to 'Clement <clement.le-pochat@ORG.fr>', 'Equipe-Exploit-Bron <cete-lyon.exploitation.sg@ORG.fr>' -subject "Export-Active-directory OUce + Siège"  -body "Bonjour veuillez trouver en pièce-jointe l'export quotidien AD de la OUCE et du Siège" -Attachment "$txtfile" -smtpServer "smtp.melanie2.i2" -encoding $encoding
 