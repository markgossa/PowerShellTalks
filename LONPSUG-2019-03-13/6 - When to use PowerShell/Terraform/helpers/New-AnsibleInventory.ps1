param(
    [parameter(Mandatory = $true)]
    [string]
    $DomainControllerVmCount,    
    [parameter(Mandatory = $true)]
    [string]
    $DomainControllerFirstHostNumber,
    [parameter(Mandatory = $true)]
    [string]
    $DomainControllerHostnamePrefix,
    [parameter(Mandatory = $true)]
    [string]
    $SubnetNetworkId,
    [parameter(Mandatory = $true)]
    [string]
    $DomainName,
    [parameter(Mandatory = $true)]
    [string]
    $Username
)

$inventoryYaml = @{
    "all" = @{
        "children" = @{
            "Windows" = @{
                "children" = @{
                    "DomainControllers" = @{
                        "hosts" = @{
                        }
                    }
                }
                "vars" = @{
                    "ansible_connection" = "winrm"
                    "ansible_winrm_server_cert_validation" = "ignore"
                    "ansible_winrm_transport" = "credssp"
                }
            }
        }
        "vars" = @{
        }
    }
}

# Add domainName var to Windows group vars
$inventoryYaml.all.children.Windows.vars.domainName = $DomainName
$inventoryYaml.all.children.Windows.vars.DomainAdministratorCredential_username = "$(($DomainName -split "\.")[0])\$Username"

# Add Domain Controller IPs to DomainControllers group
foreach ($countIndex in 0..($DomainControllerVmCount - 1))
{
    $domainControllerIp = ($SubnetNetworkId -split "\.")[0..2]
    $domainControllerIp = $domainControllerIp -join "."
    $domainControllerIp = "$($domainControllerIp).$($countIndex + $DomainControllerFirstHostNumber)"
    $DomainControllerHostname = "$($DomainControllerHostnamePrefix)000$($countIndex + 1)"

    $inventoryYaml.all.children.Windows.children.DomainControllers.hosts.$domainControllerIp = @{
        "hostname" = $DomainControllerHostname
        "ipAddress" = $domainControllerIp
    }
}

if ($DisplayOutput)
{
    ConvertTo-Yaml -Data $inventoryYaml
}

ConvertTo-Yaml -Data $inventoryYaml | Out-File -FilePath inventory.yml