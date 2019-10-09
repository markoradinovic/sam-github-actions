#!/bin/sh

# Majority taken from https://github.com/actions/aws/blob/master/cli/entrypoint.sh
# as an example

set -e

# Don't respect AWS_DEFAULT_REGION
[ -n "$AWS_DEFAULT_REGION" ] || export AWS_DEFAULT_REGION=eu-west-1

# Don't respect AWS_DEFAULT_OUTPUT if specified
[ -n "$AWS_DEFAULT_OUTPUT" ] || export AWS_DEFAULT_OUTPUT=json

# Capture output
output=$( sh -c "sam $*" )

# Preserve output for consumption by downstream actions
echo "$output" > "${HOME}/${GITHUB_ACTION}.${AWS_DEFAULT_OUTPUT}"

# Write output to STDOUT
echo "$output"
