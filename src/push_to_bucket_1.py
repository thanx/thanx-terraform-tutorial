import urllib
import boto3
import ast
import json
print('Loading function')

def lambda_handler(event, context):
    s3 = boto3.client('s3')
    sns_message = ast.literal_eval(event['Records'][0]['Sns']['Message'])
    target_bucket = 'target-bucket-one'
    source_bucket = str(sns_message['Records'][0]['s3']['bucket']['name'])
    key = str(urllib.unquote_plus(sns_message['Records'][0]['s3']['object']['key']).decode('utf8'))
    copy_source = {'Bucket':source_bucket, 'Key':key}
    # TODO: any processing here
    s3.copy_object(Bucket=target_bucket, Key=key, CopySource=copy_source)
