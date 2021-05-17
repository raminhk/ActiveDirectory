## Input from Text file

$Users= Get-Content 'c:\users.txt'
######################################################

## Input for a single User

#$Users= 'testts1'

######################################################

## Input from specific OU

#$ou = [adsi]"LDAP://OU=TestTS,DC=PSlab,DC=local"
#$usersfull = $ou.psbase.get_children() #get all users in the ou
#$users=$usersfull.cn

#######################################################
New-Item -Path "c:\" -Name "Outputs" -ItemType "directory" -Force

$Output= Foreach ($user in $Users){
$UserDN= (Get-ADUser -Identity $user -Properties distinguishedName).distinguishedName
#$UserDN
Write-Host '------------------------------------------------------------------------'
$ADUser = [ADSI]"LDAP://$UserDN"
#$ADUser
$TSAllowLogOn = $ADUser.psbase.InvokeGet('allowLogon')
if ($TSAllowLogOn -eq 1){
Write-Host "$user is Allowed to logon to RDSH server => (Value = $TSAllowLogOn)"
$user| Out-file C:\Outputs\Allowed-List.txt -Force -Append}
else{
Write-Host "$user is Denied to logon to RDSH server => (Value = $TSAllowLogOn)"
$user| Out-file C:\Outputs\Denied-List.txt -Force -Append} 

}
