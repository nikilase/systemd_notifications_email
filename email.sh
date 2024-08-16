#!/bin/bash

function usage {
    programName=$0
    echo "description: use this script to post systemd service failure message to Slack channel"
    echo "usage: $programName -s \"service name\""
    echo "	-s    the systemd service name e.g. nginx"
    exit 1
}

# Get service name from options
while getopts ":s:" opt; do
  case $opt in
    s)
      SERVICE_NAME=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

if [[ ! "${SERVICE_NAME}" ]]; then
    echo "Service name is required"
    usage
fi

# Variables
source  config.conf

TITLE_TEXT="Service $SERVICE_NAME failed on $(hostname)"

curl --url "$FROM_SMTP" --ssl-reqd \
  --mail-from "$FROM_EMAIL" \
  --mail-rcpt "$TO_EMAIL" \
  --user "${FROM_EMAIL}:${FROM_PASSWORD}" \
  -T <(echo -e "From: ${FROM_EMAIL}\nTo: ${TO_EMAIL}\nSubject: ${TITLE_TEXT}\n\n${TITLE_TEXT}")

# Exit with success code
exit 0
