# infrastructure
Infrastructure Repository for the Organization

# Command to create the stack using CloudFormation
aws cloudformation create-stack --stack-name csye6225-$(date +%s) --template-body file://csye6225-cf-networking.json --parameters file://parameters.json
 

# Command to delete the above created stack using CloudFormartion
aws cloudformation describe-stacks --stack-name $stack_name

aws cloudformation delete-stack --stack-name $stack_name

aws cloudformation wait stack-delete-complete --stack-name $stack_name