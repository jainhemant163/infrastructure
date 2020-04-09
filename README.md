# infrastructure
Infrastructure Repository for the Organization

# CSYE 6225 - Spring 2020 Cloud Computing Course
## Team Information

| Name        | NEU ID    | Email Address           |

| Hemant Jain  | 001305974 | jain.he@husky.neu.edu  |
# UNIVERSITY STUDENT BILL MANAGEGMENT SYSTEM

## Technology Stack

Programming Language: Java 1.8

Web Framework: Springboot 2.1.2.RELEASE

Database: MySQL

IDE: Eclipse IDE

Version Control: Git

Project Management: Maven

Test Tool: Postman

Development Environment: Ubuntu

## Frameworks and AWS Services Used
Springboot<br/> 
Maven<br/> 
MySQL<br/> 
GitHub Account<br/> 
Apache Tomcat Server<br/> 
Hashing Techniques<br/> 
Salting Using Bcrypt Algorithm<br/> 

**AWS Cloud Services namely**
VPC, Subnets,Internet Gateway, Route53,CloudFormation, S3 Bucket, Auto Scaling,Load Balancing,Configuration Management, CloudWatch, Log Management, SQS, SES, SNS, Lambda, ACM Certificate Management, Security Group Configuration and Management, RDS, DynamoDB.

# Command to create the stack using CloudFormation
aws cloudformation create-stack --stack-name csye6225-$(date +%s) --template-body file://csye6225-cf-networking.json --parameters file://parameters.json
 

# Command to delete the above created stack using CloudFormartion
aws cloudformation describe-stacks --stack-name $stack_name

aws cloudformation delete-stack --stack-name $stack_name

aws cloudformation wait stack-delete-complete --stack-name $stack_name

# Importing a Certificate Using the AWS CLI
The following example shows how to import a certificate using the AWS Command Line Interface (AWS CLI). The example assumes the following:

The PEM-encoded certificate is stored in a file named **Certificate.pem.**

The PEM-encoded certificate chain is stored in a file named **CertificateChain.pem.**

The PEM-encoded, unencrypted private key is stored in a file named **PrivateKey.pem.**

To use the following example, replace the file names with your own and type the command on one continuous line. The following example includes line breaks and extra spaces to make it easier to read.

	$ aws acm import-certificate --certificate file://Certificate.pem
                                 --certificate-chain file://CertificateChain.pem
                                 --private-key file://PrivateKey.pem
                                 
If the import-certificate command is successful, it returns the Amazon Resource Name (ARN) of the imported certificate.
