#!/bin/bash

## show current set region
function current_region() {
  aws configure list | awk 'END{print "current region = "$2}'
}

## list of t2-micro ec2 instance
function ec2_list() {
  aws ec2 describe-instances \
    --filters "Name=instance-type,Values=t2.micro" \
    --query 'Reservations[*].Instances[*].{Instance:InstanceId,AZ:Placement.AvailabilityZone,Name:Tags[?Key==`Name`]|[0].Value,State:State.Name}' \
    --output table --no-cli-pager
}

## Turn ec2 state 'stop' to 'running' using Tag
function ec2_run() {
  read -p "Tag key : " tag_key
  read -p "Tag Value : " tag_value

  # Get tags { Name=Shell } instance id
  local instance_id=$(aws ec2 describe-instances --filter="Name=tag:$tag_key,Values=$tag_value" \
    --query "Reservations[].Instances[].InstanceId" --output=text --no-cli-pager)
  
  aws ec2 start-instances --instance-ids $instance_id --no-cli-pager
  aws ec2 wait instance-running --instance-ids $instance_id
  
  # get ec2 public ip
  local new_ip=$(aws ec2 describe-instances --instance-ids $instance_id \
     --query 'Reservations[*].Instances[*].PublicIpAddress' \
      --output text --no-cli-pager)
  
  echo $new_ip
}

function ec2_stop() {
  echo -e "which one do you stop instance?\n"
  ec2_list

  read -p "input stopped instance-id : " stopped_instance_id

  aws ec2 stop-instances --instance-ids $stopped_instance_id --no-cli-pager

  unset stopped_instance_id
}

MENU=("ec2-list" "ec2-run" "ec2-stop" "quit")
PS3="Please select action in the list. (type number) : "

# Read user tags
#read -p "Tag key : " tag_key
#read -p "Tag Value : " tag_value

select menu in ${MENU[@]}
do
  case $menu in
    "ec2-list") ec2_list ;;
    "ec2-run") ec2_run ;;
    "ec2-stop") ec2_stop ;;
    *) echo "done!"; break;;
  esac
done
