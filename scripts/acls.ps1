$stream = new-object System.IO.StreamWriter("C:\Users\$USER\Documents\cema\Projets\AD\Acls\acl.csv")
$liste_repertoire = Get-childitem "\\$SERVER\inf" -recurse
foreach ($repertoire in $liste_repertoire)
{
if($repertoire.Attributes -eq "Directory")
{
$global_acl = Get-Acl $repertoire.FullName


foreach ($droit in $global_acl.Access)
{
$chaine = ""
$chaine += $repertoire.FullName
$chaine += ","
$chaine += $droit.IdentityReference
$chaine += ","
$chaine += $droit.FileSystemRights
$stream.WriteLine($chaine)
}
}
}
$stream.Close()
