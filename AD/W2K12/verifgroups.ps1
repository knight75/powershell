# script écrit par  Knight75
Import-Module ActiveDirectory
$gtxtdir = "D:\scripts\gpauto\txts\groups"
$listgroupauto = "$gtxtdir\listgroupauto.txt"
$listgroupauto2 = "$gtxtdir\listgroupauto2.txt"
$differences = "$gtxtdir\differences.txt"
$groups2 = "$gtxtdir\group2.txt"
reMove-Item $listgroupauto2
Get-AdGroup -filter * | Where {$_.name -like "auto.*"} | select name -ExpandProperty name > $listgroupauto2

compare-object -referenceobject $(get-content $listgroupauto ) -differenceobject $(get-content $listgroupauto2) > $differences

$TailleFichier = Get-ChildItem $differences

if ($TailleFichier.length -gt 0)
              {
                  $encoding=[System.Text.Encoding]::UTF8
                  send-mailmessage -from "SVC_CRON <Admins@ORG.i2>" -to "Admins AD <infrastructure.dsi@ORG.fr>" -subject "un groupe auto manque ou a été ajouté"  -body "Bonjour vous recevez cet email car le script de gestion des groupes automatiques a détecté qu'un groupe automatique est manquant ( <= ) ou a été ajouté ( => ). CF. piège-jointe" -Attachment "$differences" -smtpServer "smtp.melanie2.i2" -encoding $encoding
 }

