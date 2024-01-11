#!/bin/sh

if [ "$(printf '%s' "$2")" == '' ]
then
PAYLOAD="payload={\"text\": \"$1\"}"
else
PAYLOAD="payload={\"text\": \"$1\`\`\`$(echo $2 | sed "s/\"/'/g")\`\`\`\"}"
fi

if [ -n "$SLACK_PROXY" ]; then
    curl -s --proxy $SLACK_PROXY -X POST --data-urlencode "$PAYLOAD" "$GOOGLE_WEBHOOK_URL" > /dev/null
else
    curl -s -X POST --data-urlencode "$PAYLOAD" "$GOOGLE_WEBHOOK_URL" > /dev/null
fi