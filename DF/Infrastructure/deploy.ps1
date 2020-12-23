param (
    [string]$Environment,
	[string]$WwncRawDataConnString,
	[string]$SBusSendPolicy,
	[string]$AcrUsername,
	[string]$AcrPassword
)

process {
	Write-Host  "asigning env variables\n"
	Write-Host  "======================\n"
	$SUBSCRIPTION_ID = $(az account show --query 'id' --output tsv)
	$SERVICE_PRINCIPAL_ID = $Env:servicePrincipalId
	$SERVICE_PRINCIPAL_KEY = $Env:servicePrincipalKey
	$TENENT_ID = $Env:tenantId
	$PROJECT_DIR = "$($PSScriptRoot)/envs/$($Environment)"
	$SIGNEDIN_USER = $(az account show --query 'user.name' --output tsv)
	$SIGNEDIN_USER_OBJECTID = $(az ad sp show --id ${SIGNEDIN_USER} --query 'objectId' --output tsv)
	Set-Item env:ARM_CLIENT_ID -Value $Env:servicePrincipalId
	Set-Item env:ARM_CLIENT_SECRET -Value $Env:servicePrincipalKey
	Set-Item env:ARM_SUBSCRIPTION_ID -Value $(az account show --query 'id' --output tsv)
	Set-Item env:ARM_TENANT_ID -Value $Env:tenantId
	Write-Host  "ServicePrincipal: $($SUBSCRIPTION_ID)"
	Write-Host  "ClientId: $($SERVICE_PRINCIPAL_ID)"
	Write-Host  "Secret: $($SERVICE_PRINCIPAL_KEY)"
	Write-Host  "Tenant: $($TENENT_ID)"
	Write-Host  "signedin_user: $($SIGNEDIN_USER)"
	Write-Host  "signedin_clientId: $($SIGNEDIN_USER_OBJECTID)"

	Write-Host  "initializing\n"
	Write-Host  "============\n"
	cd $PROJECT_DIR
	
	Write-Host  "applying plan\n"
	Write-Host  "=============\n"
	terragrunt apply -var "tenant_id=$TENENT_ID" -var "service_bus_send_policy=$($SBusSendPolicy)" -var "wwnc_rawdata_conn_string=$($WwncRawDataConnString)" -var "signedin_clientId=$($SIGNEDIN_USER_OBJECTID)" -var "acr_username=$($AcrUsername)" -var "acr_password=$($AcrPassword)" -auto-approve 
}