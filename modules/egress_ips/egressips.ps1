param(
    $ClientId,
    $ClientSecret,
    $TenantId,
    $SubscriptionId,
    $SASToken = ""
)
function Set-EnvContext {
    param (
        [Parameter(Mandatory=$TRUE)]
        [String]
        $ClientId,
        [Parameter(Mandatory=$TRUE)]
        [String]
        $ClientSecret,
        [Parameter(Mandatory=$TRUE)]
        [String]
        $TenantId
    )
    $SecureClientSecret = ConvertTo-SecureString $ClientSecret -AsPlainText -Force
    $AzCredential = New-Object System.Management.Automation.PSCredential -ArgumentList ($ClientId, $SecureClientSecret)
    Connect-AzAccount -Credential $AzCredential -Tenant $TenantId -ServicePrincipal
    Set-AzContext -SubscriptionId $SubscriptionId 
}

function Update-EgressIpsFile { 

    $Uri = "$StorageURI?$SaSToken"
    $GMTTime = (Get-Date).ToUniversalTime().toString('R')
    $Headers = @{
    'x-ms-date' = $GMTTime
    "x-ms-version" = "2017-04-17"
    Accept = "application/json;odata=fullmetadata"
    }
    
    $CloudTable = Invoke-RestMethod -Method GET -Uri $Uri -Headers $Headers -ContentType application/json
    $TableEntriesCount = $CloudTable.Value.Count

    $CsvFilePath = "$PSScriptRoot\ipaddresses.csv"
    
    $Entries = @(
        '"address_name","cidr","start_ip","Mask bits","end_ip"'
    )

    For ( $i = 0 ; $i -lt $TableEntriesCount ; $i++ ) {
        $Description = $CloudTable.Value[$i].Description
        $Cidr =  $CloudTable.Value[$i].CIDR
        $StartIp = $CloudTable.Value[$i].StartAddress
        $MaskBits = $CloudTable.Value[$i].CIDR.Split("/")[1]
        $EndIp = $CloudTable.Value[$i].EndAddress

        $Entry = "`"$Description`",`"$Cidr`",`"$StartIp`",`"$MaskBits`",`"$EndIp`""
        $Entries += $Entry
    }
    Set-Content -Path $CsvFilePath -Value $Entries  
}

Write-Host "Pulling latest ips from storage"
# Set-EnvContext -ClientId $ClientId -ClientSecret $ClientSecret -TenantId $TenantId
# Update-EgressIpsFile
