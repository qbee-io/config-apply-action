#!/bin/bash -l

#inputs
token=$1
file_path=$2
node_id=$3
form_type=$4
commit_message=$5
api_host=$6

echo -e "init token: $token\nfilename: $file_path\nnode_id: $node_id\nform_type: $form_type\ncommit_message: $commit_message\napi_host: $api_host"

config_payload=$(jq -rc --arg node_id "$node_id" --arg formtype "$form_type" '{"node_id":$node_id,"formtype":$formtype,"config":.}' < "$file_path")
curl -s -X POST --header "Authorization: Bearer $token" \
  -H "Content-type: application/json" --url "https://${api_host}/api/v2/change" \
  -d "${config_payload}" -w "%{http_code}"

commit_payload=$(jq -nrc --arg commit_message "$commit_message" '{"action":"commit","message":$commit_message}')
curl -s -X POST --header "Authorization: Bearer $token" \
  -H "Content-type: application/json" --url "https://${api_host}/api/v2/commit" \
  -d "${commit_payload}" -w "%{http_code}"
