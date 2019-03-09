# Load Outlook
Add-Type -assembly "Microsoft.Office.Interop.Outlook"
$Outlook = New-Object -comobject Outlook.Application
$namespace = $Outlook.GetNameSpace("MAPI")
$inbox = $namespace.Folders.Item(1).Folders | Where-Object {$_.name -eq "inbox"}

# Register for Outlook search results
Register-ObjectEvent -InputObject $outlook -EventName "AdvancedSearchComplete" -Action {
    
    Write-Host "ADVANCED SEARCH COMPLETE" $Args.Scope
    
    if ($Args.Results) 
    {  
        foreach ($result in $Args.Results) 
        {
            write-host "=================================================="
            write-host $result.Subject
            write-host $result.ReceivedTime
            write-host $result.SenderName
            write-host "=================================================="
        }
    }
}

# Create a new Outlook search
$outlook.AdvancedSearch("Inbox","urn:schemas:httpmail:subject ci_phrasematch 'Train' AND urn:schemas:httpmail:sender ci_phrasematch 'James' AND urn:schemas:httpmail:textdescription ci_phrasematch 'Approve'")


# Send email with Outlook
$Mail = $Outlook.CreateItem(0)
$Mail.To = "mark.gossa@vanquisbank.co.uk"
$Mail.Subject = "Lunch"
$Mail.HTMLBody = "When is lunch?"
$Mail.Send()
