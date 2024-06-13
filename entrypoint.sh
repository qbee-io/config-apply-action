#!/bin/sh

#inputs
config_path=$1
entity_id=$2
bundle=$3
commit_message=$4
template_params=$5
is_tag=$6

TARGET_OPT="--node $entity_id"

if [[ -n $is_tag ]]; then
  TARGET_OPT="--tag $entity_id"
fi

qbee-cli config save --config $config_path --bundle $bundle $TARGET_OPT

if [[ -n "$commit_message" ]]; then
  qbee-cli config commit --commit-message "$commit_message"
fi
