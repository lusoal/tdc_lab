import boto3
import sys

def change_dns_record(zone_id, dns_name, resource_records, dns_type):
    client = boto3.client('route53')
    response = client.change_resource_record_sets(
        HostedZoneId=zone_id,
        ChangeBatch={
            'Changes': [
                {
                    'Action': 'UPSERT',
                    'ResourceRecordSet': {
                        'Name': dns_name,
                        'Type': dns_type,
                        'TTL': 60,
                        'ResourceRecords': [
                            {
                                'Value': resource_records
                            },
                        ]
                    }
                }
            ]
        }
    )

    if (response.get('ResponseMetadata').get('HTTPStatusCode')) == 200:
        return True
    else:
        return False

def main():
    zone_id = sys.argv[1]
    dns_name = sys.argv[2]
    resource_record = sys.argv[3]
    dns_type = sys.argv[4]

    if (change_dns_record(zone_id, dns_name, resource_record, dns_type)):
        print ('DNS {} change succesfully'.format(dns_name))
    else:
        print ('DNS {} error to change'.format(dns_name))


if __name__ == "__main__":
    main()
