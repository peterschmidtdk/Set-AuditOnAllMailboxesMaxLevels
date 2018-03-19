$GroupVar = DistributionGroupFromExchange
Get-DistributionGroupMember $GroupVar | Get-MailboxPermission | where {$_.user.tostring() -ne "NT AUTHORITY\SELF" -and $_.IsInherited -eq $false} | Select Identity,User,@{Name='Access Rights';Expression={[string]::join(', ', $_.AccessRights)}} | Export-Csv -NoTypeInformation .\DelegatedMailboxPermissions.csv

$Members=Get-DistributionGroupMember $GroupVar
 
foreach ($Member in $Members) { 
    
    Write-Host $Member
    # Set the MailFrom, MailTo, MailServer and Days
    # Download the Get-MailboxAuditLogging script from Practical365.com, credit by Paul Cunningham.
    .\Get-MailboxAuditLogging.ps1 -Mailbox $Member -SendEmail -Hours 750 -MailFrom noreply@domain.com -MailTo mailuser@domain.com -MailServer localhost -Verbose
     }
