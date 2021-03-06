# gcp access compute instance howto

- ref: https://cloud.google.com/sdk/gcloud/reference/compute/instances/

## Prerequisite
- Install google cloud sdk & create google account

## gcloud login

```
gcloud auth login
gcloud config get-value project
gcloud config set project ${PROJECT_ID}
PROJECT_ID=$(gcloud config list project --format "value(core.project)")
gcloud config set compute/zone asia-northeast3  
gcloud config get-value compute/zone
```

## create compute instance
```
gcloud compute instances create gcp-cloud-test --source-snapshot=https://compute.googleapis.com/compute/v1/projects/$PROJECT_ID/global/snapshots/snapshot-cloud \
--zone=asia-northeast3-a --machine-type=n1-standard-1 --preemptible --tags=socket-test,socket-test-send 
```

or
```
gcloud compute images list
```

```
gcloud compute instances create gcp-instance-python \
--image-project=ubuntu-os-cloud \
--image=ubuntu-1804-bionic-v20201211a \
--zone=asia-northeast3-a \
--machine-type=n1-standard-1 
```
- ref:
```

gcloud beta compute --project=$PROJECT_ID instances create-with-container cloud-nav2 \
--zone=asia-northeast3-a --machine-type=n1-standard-1 --subnet=default --network-tier=PREMIUM \ 
--metadata=google-logging-enabled=true --maintenance-policy=MIGRATE \
--service-account=60051663133-compute@developer.gserviceaccount.com \
--scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
--image=cos-stable-81-12871-1185-0 --image-project=cos-cloud --boot-disk-size=10GB --boot-disk-type=pd-standard \
--boot-disk-device-name=cloud-nav2 --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring \
--container-image=ubuntu:18.04 --container-restart-policy=always \
--labels=container-vm=cos-stable-81-12871-1185-0 --reservation-affinity=any
```


```
gcloud compute instances list
```
```
gcloud compute firewall-rules create --network=NETWORK default-allow-ssh --allow=tcp:22
```
## login to compute instance via ssh

```
gcloud compute ssh --zone=asia-northeast3-a gcp-cloud-test
```

or

```
gcloud compute ssh --zone=asia-northeast3-a <username>@gcp-cloud-test 
```

## stop/start/delete

```
gcloud compute instances stop gcp-cloud-test --zone=asia-northeast3-a
gcloud compute instances start gcp-cloud-test --zone=asia-northeast3-a
gcloud compute instances delete gcp-cloud-test3 --zone=asia-northeast3-a
```

## in case that application acces to google cloud
```
gcloud auth application-default login
```
