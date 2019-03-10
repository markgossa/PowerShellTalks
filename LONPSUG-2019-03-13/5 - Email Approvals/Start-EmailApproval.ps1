function Search-Inbox
{
    [cmdletbinding()]
    param (
        [Parameter(Mandatory = $true)]
        [String]
        $Subject,

        [Parameter(Mandatory = $true)]
        [String]
        $Sender,

        [Parameter(Mandatory = $true)]
        [String]
        $Body
    )

    # Load Outlook
    Add-Type -assembly "Microsoft.Office.Interop.Outlook"
    $Outlook = New-Object -comobject Outlook.Application

    # Register for Outlook search results
    $job = Register-ObjectEvent -InputObject $outlook -EventName "AdvancedSearchComplete" -Action {
        if ($Args.Results) 
        {  
            $results = $Args.Results
        }
    }

    # Create a new Outlook search
    $outlook.AdvancedSearch("Inbox","urn:schemas:httpmail:subject ci_phrasematch '$Subject' AND urn:schemas:httpmail:sender ci_phrasematch '$Sender' AND urn:schemas:httpmail:textdescription ci_phrasematch '$Body'") | Out-Null

    $jobResults = $null

    $i = 1
    while (($null -eq $jobResults) -or ($i -eq 30) ) {
        $jobResults = & $job.module {$results}
        $i++
        Start-Sleep -Seconds 2
    }

    # Clean up
    Remove-Job -Id $job.Id -Force

    Write-Verbose "Sender: $($jobResults.SenderName)"
    Write-Verbose "Subject: $($jobResults.Subject)"
    Write-Verbose "Unread: $($jobResults.UnRead)"

    return $jobResults
}

$params = @{
    "Subject"   = "Train"
    "Sender"    = "James"
    "Body"      = "Approve"
}

$emails = Search-Inbox @params -Verbose
$emails.Body

# Send email with Outlook
$Mail = $Outlook.CreateItem(0)
$Mail.To = "lonpsug@powershell.com"
$Mail.Subject = "Hi LONPSUG!"
$Mail.HTMLBody = "Welcome to Vanquis :-)"
$Mail.Send()
