# Get User ID Of Service Principal

A task that gets the user ID of a service principal in Azure AD.

## Input of the task

`TenantID` - The tenant ID of the service principal to get the user ID for.

## How to use

1. Add the [Azure Key Vault v2 task](https://learn.microsoft.com/en-us/azure/devops/pipelines/tasks/reference/azure-key-vault-v2?view=azure-pipelines) to your pipeline to access the key vault for client ID and client secret. For instance if your key vault is named `KeyVaultName` with Azure subscription `Azure SPN` and you've stored the client ID and client secret of the service principal as `ClientId` and `ClientSecret` respectively, you can add the following task to your pipeline:

    ``` yaml
    - task: AzureKeyVault@2
      inputs:
        azureSubscription: 'Azure SPN'
        KeyVaultName: 'KeyVaultName'
        SecretsFilter: 'ClientID, ClientSecret'
    ```

2. Add the [GetSPUserID](https://marketplace.visualstudio.com/items?itemName=dsarmah.GetSPUserID) task to your pipeline. Make sure to pass the `ClientID` and `ClientSecret` secrets to the respective environment variables `CLIENT_ID` and `CLIENT_SECRET`: 
    ``` yaml
    - task: GetSPUserID@1
      inputs:
        TenantID: <Tenant ID of your SP>
      env:
        CLIENT_SECRET: $(ClientSecret)
        CLIENT_ID: $(ClientID)
    ```

## FAQs

1. Should the [GetSPUserID](https://marketplace.visualstudio.com/items?itemName=dsarmah.GetSPUserID) task immediately follow the [Azure Key Vault v2 task](https://learn.microsoft.com/en-us/azure/devops/pipelines/tasks/reference/azure-key-vault-v2?view=azure-pipelines) in the pipeline?

    No, the [GetSPUserID](https://marketplace.visualstudio.com/items?itemName=dsarmah.GetSPUserID) task need not immediately follow the [Azure Key Vault v2 task](https://learn.microsoft.com/en-us/azure/devops/pipelines/tasks/reference/azure-key-vault-v2?view=azure-pipelines) in the pipeline. You can have other tasks in between the two tasks. The important thing to note is that the [GetSPUserID](https://marketplace.visualstudio.com/items?itemName=dsarmah.GetSPUserID) task should be able to access the client ID and client secret as environment variables. 

## Get the source
The [source](https://github.com/t-dsarmah/Get-Service-Principal-User-ID) for this extension is on GitHub. You can get the source code and build the extension locally if you'd like to.

## Feedback and issues
If you have feedback or issues, please file an issue on [GitHub](https://github.com/t-dsarmah/Get-Service-Principal-User-ID/issues).

<br/>

<p align="center">
Made with 💖 in Microsoft KP Towers, Noida, India
</p>