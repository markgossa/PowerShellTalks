function Test-VblAzureRmResourceGroup
{
    [cmdletbinding()]
    param 
    (
        [parameter(Mandatory = $true)]
        [string]
        $Name,
        [parameter(Mandatory = $true)]
        [string]
        $Location
    )

    $resourceGroup = Get-AzureRmResourceGroup -Name $Name -ErrorAction SilentlyContinue
    if (!$resourceGroup)
    {
        Write-Verbose "Resource Group $Name does not exist"
        return $false
    }
    else
    {
        if ($resourceGroup.Location -ne $Location)
        {
            Write-Verbose "Resource group $Name exists in the wrong location. Expected value: $Location, actual value: $($resourceGroup.Location)"
            return $false
        }
        else 
        {
            Write-Verbose "Resource Group $Name exists in the correct location"
            return $true
        }
    }
}

function Write-VblHello {
    [cmdletbinding()]
    param 
    (
        [parameter(Mandatory = $true)]    
        [string[]]
        $Names,
        [parameter()]    
        [string]
        $Colour = "Red"
    )
    
    Write-Verbose "Writing hello to '$($Names -join ', ')' and colour is set to '$Colour'"
    foreach($Name in $Names)
    {
        Write-Host "Hello $Name" -ForegroundColor $Colour
    }
}

function New-PrivateFunction 
{
    return "Something very private"
}

Export-ModuleMember -Function Test-VblAzureRmResourceGroup,Write-VblHello
