#!/bin/bash

set -e

gcloud compute instances create gce-k8s-cluster-op --source-snapshot=https://compute.googleapis.com/compute/v1/projects/lg-cloud-robot-20200731/global/snapshots/snapshot-cloud-nav-20200831 \
--zone=asia-northeast3-a --machine-type=n1-standard-2 --preemptible --tags=nav2-port,nav2-port-snd,socket-test,socket-test-send 

gcloud compute instances create gce-k8s-cluster-01 --source-snapshot=https://compute.googleapis.com/compute/v1/projects/lg-cloud-robot-20200731/global/snapshots/snapshot-cloud-nav-20200831 \
--zone=asia-northeast3-a --machine-type=n1-standard-2 --preemptible --tags=nav2-port,nav2-port-snd,socket-test,socket-test-send 

gcloud compute instances create gce-k8s-cluster-02 --source-snapshot=https://compute.googleapis.com/compute/v1/projects/lg-cloud-robot-20200731/global/snapshots/snapshot-cloud-nav-20200831 \
--zone=asia-northeast3-a --machine-type=n1-standard-2 --preemptible --tags=nav2-port,nav2-port-snd,socket-test,socket-test-send 

gcloud compute instances create gce-k8s-cluster-03 --source-snapshot=https://compute.googleapis.com/compute/v1/projects/lg-cloud-robot-20200731/global/snapshots/snapshot-cloud-nav-20200831 \
--zone=asia-northeast3-a --machine-type=n1-standard-2 --preemptible --tags=nav2-port,nav2-port-snd,socket-test,socket-test-send 

gcloud compute instances create gce-k8s-cluster-04 --source-snapshot=https://compute.googleapis.com/compute/v1/projects/lg-cloud-robot-20200731/global/snapshots/snapshot-cloud-nav-20200831 \
--zone=asia-northeast3-a --machine-type=n1-standard-2 --preemptible --tags=nav2-port,nav2-port-snd,socket-test,socket-test-send 


gcloud compute instances create gce-k8s-master --image-project=ubuntu-os-cloud --image=ubuntu-2004-focal-v20201014 \
--zone=asia-northeast3-a --machine-type=n1-standard-2 --preemptible --tags=nav2-port,nav2-port-snd,socket-test,socket-test-send 

gcloud compute instances create gce-k8s-worker1 --image-project=ubuntu-os-cloud --image=ubuntu-2004-focal-v20201014 \
--zone=asia-northeast3-a --machine-type=n1-standard-2 --preemptible --tags=nav2-port,nav2-port-snd,socket-test,socket-test-send 

gcloud compute instances create gce-k8s-worker2 --image-project=ubuntu-os-cloud --image=ubuntu-2004-focal-v20201014 \
--zone=asia-northeast3-a --machine-type=n1-standard-2 --preemptible --tags=nav2-port,nav2-port-snd,socket-test,socket-test-send 



