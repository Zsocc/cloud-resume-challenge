import boto3
import json
# from boto3.dynamodb.conditions import Key
import os

def lambda_handler(event, context):
    
    TABLE_NAME = "Counter"
    db_client = boto3.client('dynamodb')
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table(TABLE_NAME)

    update = db_client.update_item(
        TableName=TABLE_NAME,
        Key={"id": {"N": "0"}},
        UpdateExpression="ADD visitcount :inc",
        ExpressionAttributeValues={":inc": {"N": "1"}}
    )

    getItems = table.get_item(Key={"id": 0})
    itemsObjectOnly = getItems["Item"]
    visitcount = itemsObjectOnly["visitcount"]

    response = {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
        },
        'body': json.dumps({
            "count": str(visitcount)
        }),
        "isBase64Encoded": False
    }

    return response