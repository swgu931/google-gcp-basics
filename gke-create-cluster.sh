#!/bin/bash

export my-gcp-project = "my-gcp-project"
export my-gke-cluster = "my-gke-cluster"

gcloud config set project $my-gcp-project     # project in accountn@googlemail.com
gcloud config set compute/zone asia-northeast3   # Seoul region

gcloud container clusters create nav2-cloud --project=$my-gcp-project  --cluster-version=1.15.12-gke.2 \
--machine-type=n1-standard-1 \
--num-nodes=1 \
--subnetwork=default

gcloud compute project-info describe --project $my-gcp-project 

gcloud container clusters describe $my-gke-cluster

gcloud container clusters get-credentials $my-gke-cluster
kubectl get nodes  

kubectl apply -f https://raw.githubusercontent.com/kubetm/kubetm.github.io/master/sample/practice/appendix/gcp-kubernetes-dashboard.yaml 
kubectl proxy --port=8001 &

# access to ashboard access to http://127.0.0.1:8002/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/overview?namespace=default"

