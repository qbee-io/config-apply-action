#!/bin/sh

#inputs
config_path=$1
entity_id=$2
bundle=$3
commit_message=$4
is_tag=$5
template_params=$6

TARGET_OPT="--node $entity_id"

if [[ $is_tag -gt 0 ]]; then
  TARGET_OPT="--tag $entity_id"
fi

TEMPLATE_OPT=""
if [[ -n "$template_params" ]]; then
  TEMPLATE_OPT="--template-parameters $template_params"
fi

qbee-cli config save --config $config_path --bundle $bundle $TARGET_OPT $TEMPLATE_OPT

if [[ -n "$commit_message" ]]; then
  qbee-cli config commit --commit-message "$commit_message"
fi
