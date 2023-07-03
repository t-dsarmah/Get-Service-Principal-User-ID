<#
    .SYNOPSIS
    This script outputs the user ID of a service principal.
    .DESCRIPTION
    This script outputs the user ID of a service principal.
    .NOTES
    Written by Deepam Sarmah (t-dsarmah@microsoft.com)
    #>

    [string]$TenantID = Get-VstsInput -Name TenantID

    Write-Host "Logging in with a service principal..."

    az login  --allow-no-subscriptions --service-principal --tenant $TenantID --username ${env:CLIENT_ID} --password ${env:CLIENT_SECRET}

    Write-Host "Obtaining access token for Service Principal..."

    $accessToken = az account get-access-token --resource 499b84ac-1321-427f-aa17-267ca6975798 --query "accessToken" --output tsv

    Write-Host "Getting AAD Service Principal ID for marketplace..."

    $apiVersion = "7.1-preview.3"

    $uri = "https://app.vssps.visualstudio.com/_apis/profile/profiles/me?api-version=${apiVersion}"

    $headers = @{

        Accept = "application/json"

        Authorization = "Bearer $accessToken"

    }

    $spId = Invoke-RestMethod -Uri $uri -Headers $headers -Method Get | Select-Object -ExpandProperty id

    Write-Host "`nUser ID for Service Principal: $spId"