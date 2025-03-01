#!/bin/sh

# Add strict errors.
set -eu
set -o pipefail
set -x

# Run command
echo "[debug] Testing if INPUT_JSON_FILE is set"
if [ ! -z "$INPUT_JSON_FILE" ]; then
  echo "[debug] INPUT_JSON_FILE is set to: $INPUT_JSON_FILE"
  if [ -f "$INPUT_JSON_FILE" ]; then
    echo "[debug] Executing jq with args: $INPUT_ARGS"
    OUTPUT=$(cat "$INPUT_JSON_FILE" | jq $INPUT_ARGS)
    echo "json_output=$OUTPUT" >> $GITHUB_OUTPUT
    exit 0
  fi
  echo "[error] JSON_FILE is set, but does not exist"
  exit 1
fi

echo "[debug] Testing if INPUT_JSON is set"
if [ ! -z "$INPUT_JSON" ]; then
  echo "[debug] INPUT_JSON is set to: $INPUT_JSON"
  echo "[debug] Executing jq with args: $INPUT_ARGS"
  OUTPUT=$(echo "$INPUT_JSON" | jq $INPUT_ARGS)
  echo "json_output=$OUTPUT" >> $GITHUB_OUTPUT
  exit 0
fi

echo "[error] Either argument 'json' or 'json_file' must be set!"
exit 1
