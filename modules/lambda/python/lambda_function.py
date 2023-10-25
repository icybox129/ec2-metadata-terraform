# import boto3
# def lambda_handler(event, context):
#     result = "Hello World"
#     return {
#         'statusCode' : 200,
#         'body': result
#     }

import json
import boto3
import base64

# Your secret's name and region
secret_name = "aws-managed-secrets"
region_name = "us-east-1"

#Set up our Session and Client
session = boto3.session.Session()
client = session.client(
    service_name='secretsmanager',
    region_name=region_name
)

def lambda_handler(event, context):

    # Calling SecretsManager
    get_secret_value_response = client.get_secret_value(
        SecretId=secret_name
    )
    
    #Raw Response
    print(get_secret_value_response)
   
    #Extracting the key/value from the secret
    secret = get_secret_value_response['SecretString']
    print(secret)