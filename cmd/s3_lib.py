import os
import logging

import boto3
from botocore.config import Config


def configuration_report(region):
    '''
        Returns current configuration of the AWS account
    '''
    logging.info(f"Configuration:\nProfile: {os.getenv('AWS_PROFILE')}")
    logging.info(f"Region: {os.getenv('AWS_REGION')}")
    logging.info(f"System region: {region}")

def list_buckets():
    '''
        Returns list of s3 buckets, in given region
    '''

    s3 = boto3.client('s3')
    response = s3.list_buckets()

    
    logging.info('Existing buckets:')
    for bucket in response['Buckets']:
        logging.info(f'  {bucket["Name"]}')
def create_bucket(bucket_name, region_name):
    """Create an S3 bucket in a specified region

    :param bucket_name: Bucket to create
    :param region: String region to create bucket in, e.g., 'us-west-2'
    """

    try:
        s3 = boto3.client('s3')
        location = {'LocationConstraint': region_name}
        s3.create_bucket(Bucket=bucket_name,CreateBucketConfiguration=location)
    except Exception as e:
        logging.error(e)
        return False
    return True
def destroy_bucket(bucket_name):
    """Delete an S3 bucket in a specified region

    :param bucket_name: Bucket to delete
    :param region: String region to create bucket in, e.g., 'us-west-2'
    """
    s3 = boto3.client('s3')
    try:
        # bucket = s3.Bucket(bucket_name)
        # bucket.object_versions.delete()
        # bucket.objects.all().delete()
        s3.delete_bucket(Bucket=bucket_name)

    except Exception as e:
        logging.error(e)