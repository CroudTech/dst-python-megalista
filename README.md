# Megalista

## Confluence

https://croudtech.atlassian.net/wiki/spaces/DataServices/pages/1976434689/Offline+conversions+upload
## Google repo
The original project can be found here:
https://github.com/google/megalista

## Deployment steps:

1. Before deployment, make sure that a storage bucket has been created to store Terrafrom state. You can change its name in main.tf.

2. If deploying using GiHub Actions, you will need to ensure that the service account used for deployment has IAM permissions to assign roles as it will need to assign roles to the service account it creates for Megalista. If deploying manually, make sure that your account has the right permissions.

3. Make sure that credentials have been set up (see the next section for details).

4. If using GitHub Actions for deployment, simply push to the main branch (or any other branch for a dev deployment). If deploying manually, you will need to create a file with variables (you can call it `secrets.auto.tfvars` ) in the same directory as your main.tf. Then, run `terraform init` followed by `terraform apply`. 


## Credentials set up

To access campaigns and user lists on Google's platforms, this dataflow will need OAuth tokens for an account that can authenticate in those systems.

In order to create it, follow these steps:

- Access the GCP console
- Go to the API & Services section on the top-left menu.
- On the OAuth Consent Screen and configure an Internal Consent Screen
- Then, go to the Credentials and create an OAuth client Id with Application type set as Desktop App
- This will generate a Client Id and a Client secret. Save these values as they are required during the deployment
- Run the _generate_megalista_token.sh_ script in this folder providing these two values and follow the instructions
  - Sample: `./generate_megalista_token.sh client_id client_secret`
- This will generate the _Access Token_ and the _Refresh token_
  -  The user who opened the generated link and clicked on Allow must have access to the platforms that Megalista will integrate, including the configuration Sheet, if this is the chosen method for configuration
-  Take the _Client ID_, _Client Secret_, _Access Token_ and _Refresh Token_ and put them in Secrets Manager.

## Updating binaries
_Deploy_cloud.sh_ is called automatically by the terraform stack, but it can be called manually as well. It generates metadata and reuploads it together with the job template to cloud storage. This script can be used to update job binaries without recreating the infrastructure.

##Upload types
###Google Ads
Uploads __gclid__ based offline conversions to Google Ads

https://github.com/google/megalista/wiki/Google-Ads-Offline-Conversions

####Metadata:

__Conversion name__: Name of the created conversion on google ads

__Google Ads Account (Optional):__ define a Google Ads Account Customer Id to override the Account Id defined in the General Configuration on the "Intro" tab. If the Account Id defined in the General Configuration is a Mcc account, the Mcc account will still be used for authentication, however the override Account Id will be used as the Customer Id.

###Google Analytics

Sends hits to a GA Property through Measurement Protocol using __client_id__ or __user_id__

https://github.com/google/megalista/wiki/Google-Analytics---Measurement-Protocol

####Metadata:

- __GA Property Id__

- __"1" if the hit should be non-interactive, "0" otherwise__

- __The hit type__. Allowed values are "event", "transaction" and "item". Defaults to "event" if none is provided.


###Campaign Manager
Uploads Campaign Manager offline conversions to Campaign Manager floodlights (compatible with CM, SA360 and DV360 conversion optimization and CM + DV360 audience creation) using one of __gclid__, __mobileDeviceId__, __encryptedUserId__, __matchId__.

https://github.com/google/megalista/wiki/Campaign-Manager-Offline-Conversions

__Metadata__:

- Floodlight Activity ID: Can be obtained in the URL for the activity

- Floodlight Configuration Id: Can be obtained in the URL for the activity

##Local running:
https://github.com/google/megalista/wiki/Developing-and-Testing

You can run the Beam job using a DirectRunner. You will still need GCP access to read the config. 