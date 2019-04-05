import boto3
import datetime
import os
import time

def connect_aws_resource(resource, region_name):
    try:
        client = boto3.client(resource, region_name=region_name)
        return client
    except:
        return False

def get_instances(client):
    response = client.describe_instances(
        Filters=[
        {
            'Name': 'tag:Backup',
            'Values': [
                'true',
            ]
        },
    ],
    )
    instace_dict = {'id':[], 'ami_name':[], 'ami_id':[]}
    for instances in response.get('Reservations'):
        for ec2 in instances.get('Instances'):
            instace_dict['id'].append(ec2['InstanceId'])
            for tags in ec2.get('Tags'):
                if tags.get('Key') == 'Name':
                    data = str(datetime.datetime.now().strftime("%Y%m%d%H%M%S"))
                    instace_dict['ami_name'].append(tags.get('Value')+data)
    
    for instance_name, instance_id in zip(instace_dict['ami_name'], instace_dict['id']):
        try:
            response = client.create_image(
                InstanceId=instance_id,
                 Name=instance_name,
                  NoReboot=True
            )
            instace_dict['ami_id'].append(response.get('ImageId'))

        except Exception as e:
            #Jogando para o stdout
            print (str(e))
    return instace_dict

def copy_ami(client, instance_dict, region):
    print (instance_dict)
    for image_id, image_name in zip(instance_dict.get('ami_id'), instance_dict.get('ami_name')):
        print (image_id, image_name)
        try:
            response = client.copy_image(
                Name=image_name,
                SourceImageId=image_id,
                SourceRegion=region
            )
            print (response)
        except:
            return False
    return True
       

def lambda_handler(event, context):
    region_name_source = os.environ.get('SOURCE_DEST', 'us-east-1')
    region_name_dest = os.environ.get('SOURCE_DEST', 'us-east-2')
    resource = os.environ.get('AWS_RESOURCE', 'ec2')

    client = connect_aws_resource(resource, region_name_source)
    instance_dict = get_instances(client)
    time.sleep(3)
    client = connect_aws_resource(resource, region_name_dest)
    
    if (copy_ami(client, instance_dict, region_name_source)):
        return {
            'statusCode': 200,
            'body': json.dumps('Copied Amis')
        }
    else:
        return {
            'statusCode': 503,
            'body': json.dumps('Error, something happened')
        }

