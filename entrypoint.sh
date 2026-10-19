#!/bin/sh -l

# Build the argument list with positional parameters so every value is passed
# as a single quoted argument. This avoids word splitting, glob expansion and
# argument injection from user-controlled inputs such as node_id/tag_name/template_params.
set -- config save --config "$INPUT_FILE_PATH" --bundle "$INPUT_FORM_TYPE"

# tag_name takes precedence over node_id when both are defined.
if [ "x$INPUT_TAG_NAME" != "x" ]; then
  set -- "$@" --tag "$INPUT_TAG_NAME"
else
  set -- "$@" --node "$INPUT_NODE_ID"
fi

if [ "x$INPUT_TEMPLATE_PARAMS" != "x" ]; then
  set -- "$@" --template-parameters "$INPUT_TEMPLATE_PARAMS"
fi

qbee-cli "$@"

if [ "x$INPUT_COMMIT_MESSAGE" != "x" ]; then
  qbee-cli config commit --commit-message "$INPUT_COMMIT_MESSAGE"
fi
