import boto3
import json
import datetime
import os
import time

def connect_aws_resource(resource, region_name):
    try:
        client = boto3.client(resource, region_name=region_name)
        return client
    except:
        return False

def get_rds_instances(client):
    try:
        response = client.describe_db_instances()
        dict_identifiers = {}
        for instance in (response.get('DBInstances')):
            response = client.create_db_snapshot(
                DBSnapshotIdentifier=str(instance.get('DBInstanceIdentifier'))+str(datetime.datetime.now().strftime("%Y%m%d%H%M%S")),
                DBInstanceIdentifier=str(instance.get('DBInstanceIdentifier'))
            )
            dict_identifiers[((response.get('DBSnapshot').get('DBSnapshotArn')))] = str(instance.get('DBInstanceIdentifier'))+str(datetime.datetime.now().strftime("%Y%m%d%H%M%S"))
    except Exception as e:
        print str(e)
        return False
    return dict_identifiers

def copy_db_sanpshot(client, source_region, dict_identifiers):
    for arn, name in dict_identifiers.items():
        try:
            response = client.copy_db_snapshot(
                SourceDBSnapshotIdentifier=arn,
                TargetDBSnapshotIdentifier=str(name),
                SourceRegion=source_region
            )
        except Exception as e:
            print str(e)
            return False
    return True


def lambda_handler(event, context):
    region_name_source = os.environ.get('SOURCE_DEST', 'us-east-1')
    region_name_dest = os.environ.get('DEST', 'us-east-2')
    resource = os.environ.get('AWS_RESOURCE', 'rds')

    client = connect_aws_resource(resource, region_name_source)
    list_identifiers = get_rds_instances(client)

    print (list_identifiers)

    time.sleep(300)
    #Client no us-east-2 pois eu copio o snapshot da regiao da virginia para ohio
    client = connect_aws_resource(resource, region_name_dest)

    if(copy_db_sanpshot(client, region_name_source, list_identifiers)):
        return {
            'statusCode': 200,
            'body': json.dumps('Snapshot Generate and Copied Succefully!')
        }
    else:
        return {
            'statusCode': 503,
            'body': json.dumps('Error to generate or copy snapshot!')
        }