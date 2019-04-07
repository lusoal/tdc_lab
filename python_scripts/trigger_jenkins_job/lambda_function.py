import requests
import os
import json

def trigger_jenkins_job(jenkins_url, api_token, user, job):
    response = requests.post('http://{}:{}@{}/job/{}/build/'.format(user, api_token, jenkins_url, job))
    if (response.status_code) == 201:
        return True
    else:
        False



def lambda_handler(event, context):

    jenkins_url = os.environ.get('JENKINS_HOST')
    api_token = os.environ.get('JENKINS_API_KEY')
    user = os.environ.get('JENKINS_USER')
    job = os.environ.get('JENKINS_JOB')

    if (event.get('Records')):
        if (trigger_jenkins_job(jenkins_url, api_token, user, job)):
            return {
                'statusCode': 200,
                'body': json.dumps('Jenkins Job Triggered')
            }

        else:
            return {
                'statusCode': 503,
                'body': json.dumps('Error to trigger Jenkins Job')
            }