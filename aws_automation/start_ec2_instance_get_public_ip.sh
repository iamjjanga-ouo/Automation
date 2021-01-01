#/bin/bash

# Read user tags
read -p "Tag key : " tag_key
read -p "Tag Value : " tag_value

# Get tags { Name=Shell } instance id
instance_id=$(aws ec2 describe-instances --filter="Name=tag:$tag_key,Values=$tag_value" \
  --query "Reservations[].Instances[].InstanceId" --output=text --no-cli-pager)

# start instance
aws ec2 start-instances --instance-ids $instance_id --no-cli-pager
# wait instance state is 'running'
aws ec2 wait instance-running --instance-ids $instance_id
# get ec2 public ip
new_ip=$(aws ec2 describe-instances --instance-ids $instance_id \
    --query 'Reservations[*].Instances[*].PublicIpAddress' \
    --output text --no-cli-pager)
echo $new_ip
