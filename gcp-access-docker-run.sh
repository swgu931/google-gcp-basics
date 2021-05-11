#!/bin/bash

docker run -it --rm \
--name $1 \
--net host \
-h $1 \
-v /var/run:/var/run:rw \
-v ~/second/workspace-cloud/:/shared:rw \
swgu931/google-cloud-sdk-kubespray-terraform \
/bin/bash
