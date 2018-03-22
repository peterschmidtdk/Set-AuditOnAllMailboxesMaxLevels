<#
    Author: Peter Schmidt (peter@msdigest.net)
    Blog: www.msdigest.net
    Notes:
            This script will set the maximum level of Exchange Audit level, and
            the run it against all Mailboxes in the environment.

            It needs to be run on one of the Exchange Servers.

    To Retrieve a Report of the Audit, recommended this script by Paul Cunningham:
            https://github.com/cunninghamp/Get-MailboxAuditLoggingReport.ps1

    Version:
            2018.03.03 - Inital version (PSC)
#>
#Logging
#Start-Transcript 

#Setting maximum Audit Level
$AuditAdmin="Create,FolderBind,MessageBind,SendAs,SendOnBehalf,SoftDelete,HardDelete,Update,Move,Copy,MoveToDeletedItems"
$AuditDelegate="Create,FolderBind,SendAs,SendOnBehalf,SoftDelete,HardDelete,Update,Move,MoveToDeletedItems"
$AuditOwner="Create,SoftDelete,HardDelete,Update,Move,MoveToDeletedItems,MailboxLogin"

#Set Audit Logging Days
$AuditDays=365

#Get all Mailboxes
$MBX=Get-Mailbox -ResultSize unlimited

#Setting the Audit Level for the Mailboxes
$MBX | Set-Mailbox -AuditAdmin $AuditAdmin -AuditDelegate $AuditDelegate -AuditOwner $AuditOwner -AuditEnabled:$true -AuditLogAgeLimit $AuditDays

#Stop Logging
#Stop-Transcript
