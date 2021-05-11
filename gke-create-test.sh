#!/bin/bash

gcloud config set project ${PROJECT_ID}      # project in accountn@googlemail.com
gcloud config set compute/zone asia-northeast3   # Seoul region

gcloud container clusters create cloud-test --project=${PROJECT_ID}  --cluster-version=1.15.12-gke.2 \
--machine-type=n1-standard-1 \
--num-nodes=1 \
--subnetwork=default

gcloud compute project-info describe --project ${PROJECT_ID} 

gcloud container clusters describe cloud-test

gcloud container clusters get-credentials cloud-test
kubectl get nodes  

kubectl apply -f https://raw.githubusercontent.com/kubetm/kubetm.github.io/master/sample/practice/appendix/gcp-kubernetes-dashboard.yaml 
kubectl proxy --port=8002 &

echo "please visit to GCP then disable stackdriver service in the cluster"
echo "dashboard access to http://127.0.0.1:8002/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/overview?namespace=default"

