param(
    $ClientId,
    $ClientSecret,
    $SubscriptionId,
    $ResourceGroupName,
    $StorageAccountName,
    $TenantId,
    $RetentionDays
)
$SecureClientSecret = ConvertTo-SecureString $ClientSecret -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($ClientId, $SecureClientSecret)
Connect-AzAccount -Credential $Credential -Tenant $TenantId -ServicePrincipal
$Context = Get-AzSubscription -SubscriptionId $SubscriptionId
Set-AzContext $Context
$StorageAccount = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -AccountName $StorageAccountName
$StorageContext = $StorageAccount.Context
Set-AzStorageServiceLoggingProperty -ServiceType Blob -LoggingOperations read,write,delete -RetentionDays $RetentionDays -Context $StorageContext