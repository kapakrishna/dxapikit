#!/bin/bash
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Copyright (c) 2017 by Delphix. All rights reserved.
#
# Program Name : linux_shell_authentication.sh 
# Description  : Very Basic Delphix API Example 
# Author       : Alan Bitterman
# Created      : 2017-08-09
# Version      : v1.0.0
#
# Requirements :
#  1.) curl and jq command line libraries
#  2.) Populate Delphix Engine Connection Information . ./delphix_engine.conf
#
# Usage: ./linux_shell_authentication.sh
#
#########################################################
#                   DELPHIX CORP                        #
#########################################################
 
#########################################################
## Parameter Initialization ...

. ./delphix_engine.conf

#########################################################
## Authentication ...

echo "Authenticating on ${BaseURL}"

#
# Session ...
#
echo "Session API "
curl -s -X POST -k --data @- ${BaseURL}/session -c "${COOKIE}" -H "${CONTENT_TYPE}" <<EOF
{
    "type": "APISession",
    "version": {
        "type": "APIVersion",
        "major": 1,
        "minor": 7,
        "micro": 0
    }
}
EOF


#Returned to the command line are the results (added linefeeds for readability)
#{
#  "type":"OKResult",
#  "status":"OK",
#  "result":{
#    "type":"APISession",
#    "version":{
#      "type":"APIVersion",
#      "major":1,
#      "minor":7,
#      "micro":0
#    },
#    "locale":null
#    ,"client":null
#  }
#  ,"job":null
#  ,"action":null
#}

#
# Login ...
#
echo " "
echo "Login API "
curl -s -X POST -k --data @- ${BaseURL}/login -b "${COOKIE}" -H "${CONTENT_TYPE}" <<EOF
{
  "type": "LoginRequest",
  "username": "${DMUSER}",
  "password": "${DMPASS}"
}
EOF


#Returned to the command line are the results (added linefeeds for readability)
#{
#  "status":"OK",
#  "result":"USER-2",
#  "job":null,
#  "action":null
#}


#
# Get Environment ...
#
echo " "
echo "Environment API "
curl -X GET -k ${BaseURL}/environment -b "${COOKIE}" -H "${CONTENT_TYPE}"

#Returned to the command line are the results (added linefeeds for readability) 
#{
#"type":"ListResult",
#"status":"OK",
#"result":
#[
# {"type":"WindowsHostEnvironment",
#  "reference":"WINDOWS_HOST_ENVIRONMENT1",
#  "namespace":null,
#  "name":"Window Target",
#  "description":"",
#  "primaryUser":"HOST_USER-1",
#  "enabled":false,
#  "host":"WINDOWS_HOST1",
#  "proxy":null
# },
# {
#  "type":"UnixHostEnvironment",
#  "reference":"UNIX_HOST_ENVIRONMENT-3",
#  "namespace":null,
#  "name":"Oracle Target",
#  "description":"",
#  "primaryUser":"HOST_USER-3",
#  "enabled":true,
#  "host":"UNIX_HOST-3","aseHostEnvironmentParameters":null
# }
#],
#"job":null,
#"action":null,
#"total":2,
#"overflow":false
#}

echo " "
echo "Done "
exit 0;

