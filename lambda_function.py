import json

def lambda_handler(event, context):
    import boto3

    s3 = boto3.client('s3')
    data = s3.get_object(Bucket='', Key='main.txt')
    contents = data['Body'].read().decode('utf-8')
    print(contents)

    return {
        'statusCode': 200,
        'body': str(contents),
        'headers': {
            'Content-Type': 'text/html'
        }
    }
