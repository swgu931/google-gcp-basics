#!/bin/bash

docker run -it --rm \
--name $1 \
--net host \
-h $1 \
-v /var/run:/var/run:rw \
-v ~/second/workspace-cloud/:/shared:rw \
swgu931/google-cloud-sdk-kubespray-terraform \
/bin/bash


## please follow the command below
# 
# gcloud config set project lg-cloud-robot-20200730
# gcloud config set compute/zone asia-northeast3
# gcloud compute ssh --zone=asia-northeast3-a gce-k8s-master


## then make sure that the value KUBECONFIG was properly set, otherwise run the command below
# export KUBECONFIG=/etc/kubernetes/admin.conf


