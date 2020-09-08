# gcp access compute instance howto

## Prerequisite
- Install google cloud sdk & create google account

## gcloud login

```
gcloud auth login
gcloud config get-value project
gcloud config set project lg-cloud-robot-20200731
PROJECT_ID=$(gcloud config list project --format "value(core.project)")
gcloud config set compute/zone asia-northeast3  
gcloud config get-value compute/zone
```

## create compute instance
```
gcloud compute instances create gcp-cloud-test --source-snapshot=https://compute.googleapis.com/compute/v1/projects/$PROJECT_ID/global/snapshots/snapshot-cloud \
--zone=asia-northeast3-a --machine-type=n1-standard-1 --preemptible --tags=socket-test,socket-test-send 
```

```
gcloud compute instances list
```
```
gcloud compute firewall-rules create --network=NETWORK default-allow-ssh --allow=tcp:22
```
## login to compute instance via ssh

```
gcloud compute ssh [username]@gcp-cloud-test --zone=asia-northeast3-a
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
