!#/bin/bash

export my-gcp-project = "my-gcp-project"
export my-gke-cluster = "my-gke-cluster"

gcloud container clusters delete $my-gke-cluster --project=$my-gcp-project

gcloud container clusters describe nav2-cloud
