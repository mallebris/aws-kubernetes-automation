# Changelog

All notable changes to this module will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]


## [0.0.1] - 2021-09

- added: Initial version of this terraform EKS deploy automation.
    - Create user API key pair in order to have programming access to account
        - Create a separate terraform account with permissions to it (TODO)
    - Create an s3 bucket for storing terrform credentials
        - s3 bucket permissions (TODO)
    - Configure VPC
        - Configuring VPC subnets
        - Configuring NLB
    - Configuring EKS control plane
    - Configuring ASG for EKS worker plane (access map there is no set up which is security risk)
    - Setup ingress (more gentle confioguration required)
    - Setup cluster-autoscaler
    - Deploy a couple of apps
- All the sequence of steps reflected by numbers in modules names. Scripts outside of terraform explicitly mentioned in [README](README.md)


