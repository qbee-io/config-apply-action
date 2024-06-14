#!/bin/sh -l

TARGET_OPT="--node $INPUT_NODE_ID"

if [ "x$INPUT_TAG_NAME" != "x" ]; then
  TARGET_OPT="--tag $INPUT_TAG_NAME"
fi

TEMPLATE_OPT=""
if [ "x$INPUT_TEMPLATE_PARAMS" != "x" ]; then
  TEMPLATE_OPT="--template-parameters $INPUT_TEMPLATE_PARAMS"
fi

qbee-cli config save --config "$INPUT_FILE_PATH" --bundle "$INPUT_FORM_TYPE" $TARGET_OPT $TEMPLATE_OPT

if [ "x$INPUT_COMMIT_MESSAGE" != "x" ]; then
  qbee-cli config commit --commit-message "$INPUT_COMMIT_MESSAGE"
fi
