#!/bin/bash
if [ "$HALT" == "1" ]; then
  echo "HALT don't do anything"
	exit
fi

if [[ -z "$AWS_CERT" || -z "$AWS_PRIVATE_KEY" || -z "$AWS_ROOT_CA" ]]; then
	echo "Creating AWS certificates"

	curl -X POST -H "Cache-Control: no-cache" \
		-d '{ "uuid": "'$RESIN_DEVICE_UUID'", "attributes": { "someKey": "someVal" } }' \
		$LAMBDA

fi

echo "AWS certificates exist - running app"
node /usr/src/app/server.js

