#/bin/bash

# start instance
aws ec2 start-instances --instance-ids i-08371cbe3f1d54504 --no-cli-pager
# wait instance state is 'running'
aws ec2 wait instance-running --instance-ids i-08371cbe3f1d54504
# get ec2 public ip
new_ip=$(aws ec2 describe-instances --instance-ids i-08371cbe3f1d54504 \
    --query 'Reservations[*].Instances[*].PublicIpAddress' \
    --output text --no-cli-pager)
echo $new_ip
# replace ip address in SSH config(~/.ssh/config)
#sed -i -e "s|\b(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b|${newip}|g" ~/.ssh/config
# Connect shell_ec2
ssh -i "~/.ssh/seoul.pem" ubuntu@$new_ip
