#!/bin/bash

set -e

export AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION:=us-east-1}
export TEMPLATE_FILE="template.yml"
export OUTPUT_TEMPLATE_FILE="template-packaged.yml"
export CLOUDFORMATION_BUCKET=""
export APP="cfn-example"
export ALB_VPC_ID=""
export ALB_SECURITY_GROUP=""
export ALB_SUBNET_A=""
export ALB_SUBNET_B=""

sam package \
  --region ${AWS_DEFAULT_REGION} \
  --template-file ${TEMPLATE_FILE} \
  --output-template-file ${OUTPUT_TEMPLATE_FILE} \
  --s3-bucket ${CLOUDFORMATION_BUCKET}

sam deploy \
  --region ${AWS_DEFAULT_REGION} \
  --template-file ${OUTPUT_TEMPLATE_FILE} \
  --stack-name ${APP} \
  --capabilities "CAPABILITY_IAM" \
  --tags \
    "application=${APP}" \
  --parameter-overrides \
    ALBVpcId=${ALB_VPC_ID} \
    ALBSecurityGroup=${ALB_SECURITY_GROUP} \
    ALBSubnetA=${ALB_SUBNET_A} \
    ALBSubnetB=${ALB_SUBNET_B}
