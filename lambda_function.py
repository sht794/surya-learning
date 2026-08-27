import boto3
import datetime

ec2 = boto3.client('ec2')
IST = datetime.timezone(datetime.timedelta(hours=5, minutes=30))

def lambda_handler(event, context):
    response = ec2.describe_instances()
    current_hour = datetime.datetime.now(IST).hour
    print(f"Current IST hour: {current_hour}")

    for reservation in response['Reservations']:
        for instance in reservation['Instances']:
            instance_id = instance['InstanceId']
            state = instance['State']['Name']
            tags = {tag['Key']: tag['Value'] for tag in instance.get('Tags', [])}

            print(f"Instance: {instance_id}, State: {state}, Tags: {tags}")

            if 'poweroff' in tags and state == 'running':
                if current_hour == int(tags['poweroff']):
                    print(f"Stopping instance {instance_id} (poweroff={tags['poweroff']})")
                    ec2.stop_instances(InstanceIds=[instance_id])
            elif 'poweron' in tags and state == 'stopped':
                if current_hour == int(tags['poweron']):
                    print(f"Starting instance {instance_id} (poweron={tags['poweron']})")
                    ec2.start_instances(InstanceIds=[instance_id])
