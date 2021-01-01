#/bin/bash

# TO DO
# 1. get instance-id using tags

# Get tags { Name=Shell } instance id
instance_id=$(aws ec2 describe-instances --filter="Name=tag:Name,Values=Shell" \
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

# replace ip address in SSH config(~/.ssh/config)
#sed -i -e "s|\b(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b|${newip}|g" ~/.ssh/config
