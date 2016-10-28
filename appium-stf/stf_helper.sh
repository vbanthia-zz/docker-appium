#!/usr/bin/env bash

set -euxo pipefail

if [ "$DEVICE_SERIAL" == "" ]; then
    echo "Please specify device serial using ENV['DEVICE_SERIAL']"
    exit 1
fi

if [ "$STF_URL" == "" ]; then
    echo "Please specify stf url using ENV['STF_URL']"
    exit 1
fi

if [ "$STF_TOKEN" == "" ]; then
    echo "Please specify stf token using using ENV['STF_TOKEN']"
    exit 1
fi

function add_device
{
    response=$(curl -X POST -H "Content-Type: application/json" \
                 -H "Authorization: Bearer $STF_TOKEN" \
                 --data "{\"serial\": \"$DEVICE_SERIAL\"}" $STF_URL/api/v1/user/devices)

    success=$(echo "$response" | jq .success | tr -d '"')
    description=$(echo "$response" | jq .description | tr -d '"')

    if [ "$success" != "true" ]; then
        echo "Failed because $description"
        exit 1
    fi

    echo "Device $DEVICE_SERIAL added successfully"
}

function remote_connect
{
    response=$(curl -X POST -H "Content-Type: application/json" \
                 -H "Authorization: Bearer $STF_TOKEN" \
                $STF_URL/api/v1/user/devices/$DEVICE_SERIAL/remoteConnect)

    success=$(echo "$response" | jq .success | tr -d '"')
    description=$(echo "$response" | jq .description | tr -d '"')

    if [ "$success" != "true" ]; then
        echo "Failed because $description"
        exit 1
    fi
    remote_connect_url=$(echo "$response" | jq .remoteConnectUrl | tr -d '"')

    adb connect $remote_connect_url

    echo "Device $DEVICE_SERIAL remote connected successfully"
}

function remove_device
{
    response=$(curl -X DELETE -H "Content-Type: application/json" \
                 -H "Authorization: Bearer $STF_TOKEN" \
                $STF_URL/api/v1/user/devices/$DEVICE_SERIAL)

    success=$(echo "$response" | jq .success | tr -d '"')
    description=$(echo "$response" | jq .description | tr -d '"')

    if [ "$success" != "true" ]; then
        echo "Failed because $description"
        exit 1
    fi

    echo "Device $DEVICE_SERIAL removed successfully"
}

function start_appium
{
    add_device
    remote_connect
    appium
}

$@
