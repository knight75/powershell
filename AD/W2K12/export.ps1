﻿Get-ADUser -Filter { department -like "OUMed/ALR*" -and (-not (lastLogonTimeStamp -gt 0)) } -SearchBase "OU=users,OU=OUMed,DC=ORG,DC=FR" |Select-Object @{Label = "First Name";Expression = {$_.GivenName}},  
                  @{Label = "Last Name";Expression = {$_.Surname}},
                  @{Label = "identifiant";Expression = {$_.samaccountname}} | ConvertTo-Csv -Delimiter "," -NoTypeInformation | foreach { $_ -replace '"',''} | out-file C:\Users\.Knight75\Documents\ORG\Projets\AD\mails\export-alr.csv -fo -en utf8