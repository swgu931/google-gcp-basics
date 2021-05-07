#!/bin/bash

docker run -it --rm \
--name gcp-sdk \
--net host \
-h gcp-sdk \
-v /var/run:/var/run:rw \
-v ~/second/workspace-cloud/:/shared:rw \
swgu931/google-cloud-sdk-kubespray-terraform \
/bin/bash


docker run -it --rm \
--name gcp-sdk \
--net host \
-h gcp-sdk \
-v /var/run:/var/run:rw \
-v ~/second:/shared:rw \
swgu931/google-cloud-sdk-kubespray-terraform \
/bin/bash
