#!/usr/bin/env python3
'''
    Script designed for creating/destroying resources outside of the terraform 
    automation.
'''

import argparse
import logging

import s3_lib as s3l
import iam_lib as iaml

REGION = "us-east-2"
BUCKET_NAME = "terraform-state-automatization"

def main():
    parser = argparse.ArgumentParser(
        description="Script for managing AWS resources outside of the terraform",
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument(
        "--operation",
        action="store",
        required=True,
        help="Define the operation that needed to be actioned. Possible values "
        "[create, destroy]",
    )
    parser.add_argument(
        "--log",
        action="store",
        default="INFO",
        help="Defines the log level. Default: INFO",
    )

    args = parser.parse_args()

    numeric_level = getattr(logging, args.log.upper(), None)
    
    if not isinstance(numeric_level, int):
        raise ValueError("Invalid log level: %s" % args.log)
    
    logging.basicConfig(
        format="%(asctime)s %(levelname)s:%(message)s",
        datefmt="%m/%d/%Y:%I:%M:%S:%p",
        level=numeric_level,
    )
    
    s3l.configuration_report(REGION)
    s3l.list_buckets()
    if args.operation == "create":
        if s3l.create_bucket(bucket_name=BUCKET_NAME, region_name=REGION):
            logging.info(f"Bucker {BUCKET_NAME}, created")
        else:
            logging.error(f"Bucker {BUCKET_NAME}, creation failed")
        # iaml.create_iam_group()
    elif args.operation == "destroy":
        s3l.destroy_bucket(bucket_name=BUCKET_NAME)
        # iaml.destroy_iam_group()
    else:
        logging.error(f"Operation is not supported")


if __name__ == "__main__":
    main()