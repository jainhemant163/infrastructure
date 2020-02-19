#!/bin/bash
echo "DELETING STACK"
stack_name=$1

#Query the stack
aws cloudformation describe-stacks --stack-name $stack_name

aws cloudformation delete-stack --stack-name $stack_name

aws cloudformation wait stack-delete-complete --stack-name $stack_name


echo "STACK TERMINATED SUCCESSFULLY"