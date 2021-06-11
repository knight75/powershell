# Script écrit par  Knight75
Import-Module ActiveDirectory
$separator = "-"
$SourcePath = "CN=Computers,DC=ORG,DC=fr"
$computers = Get-ADComputer -Filter * -SearchBase $SourcePath
$TargetOUVal = @{"02" = "OUCEMF" ; "03" = "OUCEMF" ; "04" = "OUCEMF" ; "15" = "OUCTV" ; "40" = "OUCE" ; "41" = "OUCE" ; "42" = "OUCE" ; "43" = "OUCE" ; "50" = "OUMed" ; "51" = "OUMed" ; "53" = "OUMed" ; "401" = "Siège"}
if(!$Computers) {
 write-host "No Computers found in default container"
 return
}
foreach ($ordinateur in $Computers) {
$Computer = $ordinateur.name
$Computer = $computer.Split($separator)[0] -replace "[a-z]",""
 if($TargetOUVal.containskey("$computer")) {
$key = "$Computer"
$Target = $TargetOUVal.$key
$TargetOU="OU=Ordinateurs,OU=$Target,DC=ORG,DC=fr"
Move-ADObject $ordinateur -TargetPath $TargetOU
$Status = "SUCCESS"
 } else {
  $Status = "FAILED"
 }
 $OutputObj = New-Object -TypeName PSobject
 $OutputObj | Add-Member -MemberType NoteProperty -Name ComputerName -Value $ordinateur.name.tostring()
 $OutputObj | Add-Member -MemberType NoteProperty -Name SourcePath -Value $SourcePath
 $OutputObj | Add-Member -MemberType NoteProperty -Name DestinationPath -Value $TargetOU
 $OutputObj | Add-Member -MemberType NoteProperty -Name Status -Value $Status
 $OutputObj
}

