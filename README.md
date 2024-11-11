# System Information Collection and Email Reporting Script

## Overview

This PowerShell script gathers detailed system information, encrypts the data, and emails the report to a specified address. It's designed for use in environments where system diagnostics are required for security, maintenance, or auditing purposes. 

The script performs the following tasks:
1. Collects system and network information.
2. Saves the information to a file.
3. Encrypts the file for secure transmission.
4. Emails the encrypted report to the designated recipient.

This script is useful for administrators, security professionals, or educators who need to demonstrate secure information gathering and transmission techniques.

## Features

- **System Information Gathering**: Collects OS details, IP configuration, network connections, running tasks, and user accounts.
- **File Encryption**: Uses basic encoding to protect data during transfer.
- **Email Transmission**: Sends the encrypted file via SMTP.

## Prerequisites

- **PowerShell**: Ensure PowerShell 5.0 or later is installed on the system.
- **SMTP Access**: Access to an SMTP server (e.g., Gmail SMTP) to send emails. For Gmail, enable an [App Password](https://support.google.com/accounts/answer/185833) if two-factor authentication is used.

## Setup

1. **Edit the Script Parameters**:
   - Replace `$SmtpServer`, `$From`, `$To`, `$Username`, and `$Password` with your SMTP server details, sender and recipient email addresses, and SMTP login credentials.
   - Example:
     ```powershell
     $SmtpServer = "smtp.gmail.com"
     $From = "your-email@gmail.com"
     $To = "recipient-email@example.com"
     $Username = "your-email@gmail.com"
     $Password = "your-app-password"
     ```

2. **Save the Script**:
   - Save the script with a `.ps1` extension (e.g., `send_sysinfo_report.ps1`).

## Usage

### Step-by-Step Execution

1. **Open PowerShell as Administrator**:
   - Right-click on the **Start** button and choose **Windows PowerShell (Admin)**.

2. **Set Execution Policy (if needed)**:
   - If you encounter an execution policy error, temporarily bypass the restriction by running:
     ```powershell
     Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
     ```
   
3. **Run the Script**:
   - Navigate to the script's directory in PowerShell and execute it:
     ```powershell
     .\send_sysinfo_report.ps1
     ```

4. **Verify Email**:
   - Check the specified recipient email inbox for the report. If successful, the email will contain an attachment with encrypted system information.

### Script Walkthrough

1. **System Information Collection**: 
   - Gathers system information such as the computer name, OS version, network configuration, active connections, and more.
   
2. **File Encryption**: 
   - Encodes the collected information using `certutil` for basic encryption.

3. **Email Transmission**:
   - Configures the SMTP client and attaches the encrypted file, sending it securely to the designated recipient.

4. **Cleanup**:
   - Deletes the plaintext and encrypted files from the local machine after sending the email.

## Important Security Notes

- **Use Responsibly**: Only use this script in environments where you have permission to gather and send system information.
- **Handle Credentials Carefully**: Keep your email credentials secure. Use environment variables or encrypted credential storage for additional security in production.
- **Test in a Safe Environment**: For best practice, run this script in a secure, isolated environment.

## Troubleshooting

- **Execution Policy Error**: Set execution policy temporarily as described above.
- **SMTP Issues**: Ensure the SMTP server settings, username, and password are correct. For Gmail, use App Passwords if two-factor authentication is enabled.
- **Permission Denied**: Run PowerShell as an administrator to ensure all commands execute properly.
