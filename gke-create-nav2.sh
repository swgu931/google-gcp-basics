#!/bin/bash

gcloud config set project ${PROJECT_ID}     # project in accountn@googlemail.com
gcloud config set compute/zone asia-northeast3-a   # Seoul region

gcloud container clusters create cloud-nav2 --project=${PROJECT_ID} --cluster-version=1.15.12-gke.2 \
--machine-type=n1-standard-2 \
--num-nodes=1 \
--subnetwork=default

gcloud container clusters get-credentials cloud-nav2 --zone asia-northeast3-a --project lg-cloud-robot-20200908

gcloud compute project-info describe --project ${PROJECT_ID}
gcloud container clusters describe cloud-nav2
kubectl get nodes -o wide 

kubectl apply -f https://raw.githubusercontent.com/kubetm/kubetm.github.io/master/sample/practice/appendix/gcp-kubernetes-dashboard.yaml 
nohup kubectl proxy --port=8001  1>/dev/null 2>&1 &

http://127.0.0.1:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/pod?namespace=default



echo "please visit to GCP then disable stackdriver service in the cluster to reduce cost"
echo "dashboard access to http://127.0.0.1:8002/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/overview?namespace=default"




