# aws-kubernetes-automation

## Overview
This is a simple example of the AWS EKS cluster deployment.

## Dependecies

Tools:
- [direnv](https://direnv.net/)
- [tfenv](https://github.com/tfutils/tfenv)

Here described depencies related to the upstream providers

1. Providers:
    - VPC provider
    - EKS provider
    - Nginx ingress
    - cluster-autoscaler
2. Applications:
    - kafka - random stateful set setup
    - grafana web UI - random web application

*Note: in terms of applications any restapi based application will be simplier in terms of ingress etc.*

## Security constrains and assumptions
1. s3 bucket as terraform backend is not protected by aws policies, ideally there should be constrains based on IAM user role/group
2. Created a separate VPC - allows to mutate apply more strict rules without risk of losing default VPC for region
3. VPC is separated by two parts 3 public subnets, 3 private subnets
4. Separate NLB (ideally in-band) allows to have independent component out side of the helm charts, located 
5. EC2 instances roles - is a potentuall risk it allows every app get access to the wide pool of resopurces/services ideally access to resources should be based on k8s RBAC
6. Access on k8s level is not granular, because only one real user of the platform that auth via sts. For bigger user svc landscape permissions should be granted based on RBAC

## Reability constrains and assumptions
1. s3 bucket as terraform backend, not versioned which is downside. For demo env versioning looks overhead
2. DynamoDB terraform lock - does not required because there is no concurency between developers/automation
3. Each vpc subnet located in separate AZ
4. EC2 instances run in autoscale group, which managed by k8s internal autoscaler cluster tool
5. Ingress is DaemonSet - because ingress runs in NodePort mode and did not distrubute traffic by itself

## How to run

1. In order to store the terraform state used s3 bucket it should be created before further automation can be applied
    ```bash
        cd aws-kubernetes-automation/cmd
        python3 acc_mng.py --operation destroy
    ```
2. In order to create the other infra components run
    ```bash
        cd aws-kubernetes-automation/env_dir/tf
        terraform init
        terraform plan -out=create.plan
        terraform apply create.plan
    ```


## Cleanup
There is no changes outside of the code. This repository should be used for cleaning up.

1. The major infrastructure build via terraform
    ```bash
        terraform plan -destroy -out=destroy.plan
        terraform apply destroy.plan
    ```
2. Delete s3 bucket
    ```bash
        cd aws-kubernetes-automation/cmd
        python3 acc_mng.py --operation destroy
    ```