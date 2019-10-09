#!/bin/sh

set -e

output=$( sh -c "sam $*" )
echo "$output" > "${HOME}/${GITHUB_ACTION}.${AWS_DEFAULT_OUTPUT}"
echo "$output"
