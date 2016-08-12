#!/bin/bash

set -x

if [ "$HALT" == "1" ]; then
  echo "start.sh: ENV HALT=1; don't do anything"
	exit
fi

env

if [[ -z "$AWS_CERT" || -z "$AWS_PRIVATE_KEY" || -z "$AWS_ROOT_CA" ]]; then
	echo "start.sh: Creating AWS certificates"

	curl -X POST -H "Cache-Control: no-cache" \
		-d '{ "uuid": "'$RESIN_DEVICE_UUID'", "attributes": { "someKey": "someVal" } }' \
		$LAMBDA

fi

if [[ -z ${AWS_CERT+x} || -z ${AWS_PRIVATE_KEY+x} || -z ${AWS_ROOT_CA+x} ]]; then
	echo "fatal: start.sh: AWS_CERT, AWS_PRIVATE_KEY and/or AWS_ROOT_CA not set! exiting!"

	exit 1
else
	echo "start.sh: AWS certificates exist - running app"

	node /usr/src/app/server.js
fi

