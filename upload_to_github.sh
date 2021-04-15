#!/bin/bash

GITHUB_TOKEN=$1
FILE_LOC=$2
FILE_NAME=$3

# If needed
# export http_proxy=10.192.254.254:8080
# export https_proxy=10.192.254.254:8080

echo "$raw_content" > input.txt

openssl base64 -in $FILE_LOC/$FILE_NAME > encoded.txt

enc_contents=$(tr -d "\n\r" < encoded.txt)

curl -i -X PUT -H 'Authorization: token $GITHUB_TOKEN' \
-d "{\"message\":\"incoming!\", \"content\":\""$enc_contents"\"}" \
https://api.github.com/repos/Ma-Eloiza-Tabing/<repo_name>/contents/$FILE_NAME
