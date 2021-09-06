import logging
import json

import boto3
from botocore.config import Config

def create_iam_group(group_name="terraform", region="us-east-2"):
    """Create an AWS IAM group

    :param group_name: IAM group to create
    :param region: String region to create group
    """
    iam = boto3.client('iam', region_name=region)
    try:
        iam.create_group( Path='/', GroupName=group_name)
    except Exception as e:
        logging.error(e)

def attach_policy_group():
    # Create IAM client
    iam = boto3.client('iam')

    iam.attach_role_policy(
        PolicyArn='arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess',
        RoleName='AmazonDynamoDBFullAccess'
    )

def create_iam_policy(bucket_name, policy_name="terraform_permissions"):
    """Create an AWS IAM policy

    :param policy_name: IAM policy to create
    :param region: String region to create policy
    """
    
    iam = boto3.client('iam')

    policy = {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": "s3:ListBucket",
                "Resource": f"arn:aws:s3:::{bucket_name}"
            },
            {
                "Effect": "Allow",
                "Action": ["s3:GetObject", "s3:PutObject"],
                "Resource": f"arn:aws:s3:::{bucket_name}"
            }
        ]
    }
    logging.info(f"Creating iam policy: {policy_name}")
    logging.debug(f"Policy definition: {policy}")
    try:
        iam.create_policy(
            PolicyName=policy_name,
            PolicyDocument=json.dumps(policy)
        )
    except Exception as e:
        logging.error(e)

def destroy_iam_group(group_name="terraform", region="us-east-2"):
    """Delete an AWS IAM group

    :param group_name: IAM group to delete
    :param region: String region to delete group
    """
    iam = boto3.client('iam', region_name=region)
    try:
        iam.delete_group(GroupName=group_name)
    except Exception as e:
        logging.error(e)

def destroy_iam_policy(policy_name="terraform", region="us-east-2"):
    """Delete an AWS IAM policy

    :param policy_name: IAM policy to delete
    :param region: String region to delete policy
    """
    iam = boto3.client('iam', region_name=region)
    try:
        iam.delete_group(GroupName=policy_name)
    except Exception as e:
        logging.error(e)