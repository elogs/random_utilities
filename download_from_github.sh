#!/bin/bash

GITHUB_TOKEN=$1
FILE_PATH=$2
FILE_NAME=$3

# If needed
# export http_proxy=10.192.254.254:8080
# export https_proxy=10.192.254.254:8080

curl --header 'Authorization: token $GITHUB_TOKEN' \
--header 'Accept: application/vnd.github.v3.raw' \
--remote-name \
--location https://api.github.com/repos/elogs/<repo-name>/contents/$FILE_PATH


# NOT WORKING YET. 
# For big files, we first need to get the sha value of a particular file
# then use that sha to download from 'blobs' dir of your repo

# to get the sha
# curl --header 'Authorization: token $GITHUB_TOKEN' \
#--header 'Accept: application/vnd.github.v3.raw' \
#https://api.github.com/repos/elogs/transit/git/trees/master

# then to download
#curl --header 'Authorization: token $GITHUB_TOKEN' \
#--header 'Accept: application/vnd.github.v3.raw' \
#--remote-name \
#--location https://api.github.com/repos/elogs/<repo-name>/git/blobs/<sha_value>

