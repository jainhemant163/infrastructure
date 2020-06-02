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

## Infrastructure as a Code with AWS CloudFormation:
1. Install and setup AWS command line interface
2. Create CloudFormation template networking.json or networking.yaml that can be used to setup required networking resources
3. Create CloudFormation template application.json or application.yaml that can be used to setup required application resources
4. Create CloudFormation template auto_scaling_application.json or auto_scaling_application.yaml that can be used to setup required auto scaling and serverless resources

## AWS CloudFormation:

### AWS Networking Setup:
Here what you need to do for networking infrastructure setup:

1. Created a Virtual Private Cloud (VPC).
2. Created subnets in the VPC with 3 subnets, each in different availability zone in the same region in the same VPC.
3. Created Internet Gateway resource and attached the Internet Gateway to the VPC.
4. Created a public route table and attached all subnets created above to the route table.
5. Created a public route in the public route table created above with destination CIDR block 0.0.0.0/0 and internet gateway created above as the target.

### AWS Application Setup:
Here what you need to do for application infrastructure setup:

1. Created application.yaml to set up resources required for deploying web application in the encrypted private S3 bucket and connect to RDS instance when running on cloud (by creating EC2 instances)
2. The CloudFormation template works in the same AWS account and region to create multiple stacks including all of it resources.
3. The CloudFormation template works in any AWS account and in any AWS region.
4. Added required IAM policies and roles for secure access to various AWS services, security group for application to run on port 8080 for tomcat server and port 5432 for databse servers, RDS instance for postgres DB, EC2 instance, S3 bucket, code deploy application and deployment group.

#### EC2 & Userdata:
Make following updates to the EC2 resource:

1. EC2 instance is launched with user data.
2. EC2 instance is tagged appropriately so that CodeDeploy can identify EC2 instances on which application is suppose to be deployed.
3. Database username, password, hostname is passed to the web application using user data.
4. S3 bucket to store images is passed to the application via EC2 user data.

#### Web App User Stories:
1. All API request/response payloads should be in JSON.
2. No UI should be implemented for the application.
3. As a user, I expect all APIs call to return with proper HTTP status code.
4. As a user, I expect the code quality of the application is maintained to highest standards using unit and/or integration tests.
5. As a user, I want to use the RDS instance on the cloud to store data when my application is running on EC2 instance.
6. As a user, I want to use S3 bucket to store user’s attachments instead of local disk.
7. As a user, I want the S3 object metadata to be stored in the database.
8. As a user, I want all application log data to be available in CloudWatch.
9. As a user, I want metrics on API usage available in CloudWatch.
10. Create following custom metrics for every API we have implemented in the web application. The metrics data should be collected in CloudWatch.
    a. Count number of times each API is called.
    b. Using Timer metrics data type, time (in milliseconds) each API call so we can understand how long it takes for the application to process an API call.
    c. Using Timer metrics data type, time (in milliseconds) each database query executed by your application.
    d. Using Timer metrics data type, time (in milliseconds) each call made to AWS S3 service by your application.
11. You can retrieve custom metrics using either StatsD or collectd.
12. CloudWatch agent configuration file must be copied over to the EC2 server when application is being deployed by CodeDeploy. You will also need to configure CloudWatch agent before starting your service.

#### Bootstrapping Database:
1. The application setups the database schema if it is not already there. Hibernate ORM framework is used for the same.
2. The application makes necessary schema updates during startup.
3. Database changes cannot be done by accessing RDS instance.

### AWS Auto Scaling Application Setup:
So far our web application has been accessible by IP address in plain text (HTTP). We will now disable direct access to our web application. The web application will now only be accessible from load balancer.
Here what you need to do for auto scaling application infrastructure setup:

1. Auto scaling for EC2 instances using Launch configuration, policies, roles and auto scaling group.
2. Load balancer for web application to accept HTTP traffic on port 80 and forward it to your application instances on whatever port it listens on.
3. Updated CodeDeploy so that code changes can be deployed to all instances.
4. Route53 so that the domain points to the load balancer and the web application is accessible via root context http://your-domain-name.tld/
5. SES, SNS, SQS and Lambda configuration to push data into the queue and SNS to continuously poll the queue to get the message and trigger lambda function which is subscribed on SNS to send automated emails to the user about all the due bills.
6. DynamoDB to store information requested while triggering lambda and enable monitoring and tracking of emails sent to the user.

## AWS-CLI Instructions:

### Install AWS-CLI:
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" 

unzip awscliv2.zip 

sudo ./aws/install

### Configure AWS-CLI:

aws configure profile [profile-name]

## Create CloudFormation stack using AWS-CLI:

1. Networking stack -

aws cloudformation create-stack \
    --stack-name networkstack \
    --parameters  file://networking_parameters.json \
    --template-body file://networking.yaml \
    --profile dev \
    --region us-east-1

2. Application stack -

aws cloudformation create-stack \
  --stack-name applicationstack \
  --parameters  file://application_parameters.json \
  --template-body file://application.yaml \
  --capabilities CAPABILITY_NAMED_IAM \
  --profile dev \
  --region us-east-1

3. Auto scaling stack:

aws cloudformation create-stack \
  --stack-name autoScalingApplicationStack \
  --parameters  file://auto_scaling_application_parameters.json \
  --template-body file://auto_scaling_application.yaml \
  --capabilities CAPABILITY_NAMED_IAM \
  --profile dev \
  --region us-east-1

## Delete CloudFormation stack:
Remove any object from S3 bucket before deleting the stack using following command:
aws s3 rm s3://[bucket-name] --recursive --profile [profile-name]

aws cloudformation delete-stack \
    --stack-name [stack-name] \
    --profile [profile-name]

## Wait for CloudFormation Stack Deletion
aws cloudformation wait stack-delete-complete \
    --stack-name [stack-name]

## Command to generate Certificate ARN by importing it to AWS ACM:

sudo aws acm import-certificate \
    --certificate fileb://certificate.pem \
    --certificate-chain fileb://certificate_bundle_chain.pem \
    --private-key fileb://~/aws-ssl-csr-private-key.pem \
    --profile [profile-name]
