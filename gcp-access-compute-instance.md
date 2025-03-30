# Howto Create gcp compute instance and Delete them

- ref: https://cloud.google.com/sdk/gcloud/reference/compute/instances/

## Prerequisite
- Install google cloud sdk & create google account

## gcloud init
```
gcloud init
```

## gcloud login

```
gcloud auth login
gcloud config get-value project
gcloud config set project ${PROJECT_ID}
PROJECT_ID=$(gcloud config list project --format "value(core.project)")
gcloud config set compute/zone asia-northeast3  
gcloud config get-value compute/zone
```

## Default Network should exist before creating compute zone
```
gcloud compute networks list
gcloud compute networks subnets list --regions=asia-northeast3

gcloud compute networks create default --subnet-mode=auto
```

## create compute instance with snapshot
```
gcloud compute instances create gcp-cloud-test \
--source-snapshot=https://compute.googleapis.com/compute/v1/projects/$PROJECT_ID/global/snapshots/snapshot-cloud \
--zone=asia-northeast3-a \
--machine-type=n1-standard-1 \
--preemptible \
--tags=socket-test,socket-test-send 
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

## create compute instance without snapshot 
```
gcloud compute instances create gcp-instance-cloudrobotics \
  --image-project=ubuntu-os-cloud \
  --image=ubuntu-2004-focal-v20250313 \
  --zone=asia-northeast3-a \
  --machine-type=e2-micro \
  --tags=cloud,robotics,cloudrobotics,control \
  --network=YOUR_NETWORK_NAME \
  --subnet=YOUR_SUBNET_NAME
```  

## Error like no serviceacount 
- The resource '60051663133-compute@developer.gserviceaccount.com' of type 'serviceAccount' was not found
### Option 1:
```
gcloud services disable compute.googleapis.com
gcloud services enable compute.googleapis.com
```
### Option 2:
```
YOUR_PROJECT_ID=cloud-robot-20200731

# Create a custom service account
gcloud iam service-accounts create cloudrobotics-sa \
  --display-name="Cloud Robotics VM Service Account"

# Give it basic permissions
gcloud projects add-iam-policy-binding $YOUR_PROJECT_ID \
  --member="serviceAccount:cloudrobotics-sa@$YOUR_PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/compute.instanceAdmin.v1"

# Re-run the instance creation with this service account
gcloud compute instances create gcp-instance-cloudrobotics \
  --image-project=ubuntu-os-cloud \
  --image=ubuntu-2004-focal-v20250313 \
  --zone=asia-northeast3-a \
  --machine-type=e2-micro \
  --tags=cloud,robotics,cloudrobotics,control \
  --network=default \
  --subnet=default \
  --service-account=cloudrobotics-sa@$YOUR_PROJECT_ID.iam.gserviceaccount.com \
  --scopes=https://www.googleapis.com/auth/cloud-platform
```

## Allow ICMP traffic in your firewall
- You need to create a firewall rule to allow ICMP (ping) from 0.0.0.0/0.
```
gcloud compute firewall-rules create allow-icmp \
  --network=default \
  --allow=icmp \
  --source-ranges=0.0.0.0/0 \
  --target-tags=cloudrobotics \
  --description="Allow ping to instances tagged with cloudrobotics"
```

```
gcloud compute instances list
```
```
gcloud compute firewall-rules create --network=NETWORK default-allow-ssh --allow=tcp:22
```
## login to compute instance via ssh
gcloud compute firewall-rules create allow-icmp \
  --network=default \
  --allow=icmp \
  --source-ranges=0.0.0.0/0 \
  --target-tags=cloudrobotics \
  --description="Allow ping to instances tagged with cloudrobotics"
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

## In case that application acces to google cloud
```
gcloud auth application-default login
```



# Delete all the resource so as not to pay anything.
- How to remove (delete) all resources so you don't get charged

```
# Delete the VM instance
gcloud compute instances delete gcp-instance-cloudrobotics \
  --zone=asia-northeast3-a


# Delete the static external IP (if you reserved one manually)  
gcloud compute addresses list
gcloud compute addresses delete YOUR_IP_NAME --region=YOUR_REGION


# Delete firewall rules (optional)
gcloud compute firewall-rules delete allow-icmp
  
#  
gcloud iam service-accounts delete cloudrobotics-sa@YOUR_PROJECT_ID.iam.gserviceaccount.com
```
  


---
## Reference
```
gcloud beta compute \
--project=$PROJECT_ID instances create-with-container cloud-nav2 \
--zone=asia-northeast3-a \
--machine-type=n1-standard-1 \
--subnet=default \
--network-tier=PREMIUM \ 
--metadata=google-logging-enabled=true \
--maintenance-policy=MIGRATE \
--service-account=60051663133-compute@developer.gserviceaccount.com \
--scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
--image=cos-stable-81-12871-1185-0 \
--image-project=cos-cloud \
--boot-disk-size=10GB \
--boot-disk-type=pd-standard \
--boot-disk-device-name=cloud-nav2 \
--no-shielded-secure-boot \
--shielded-vtpm \
--shielded-integrity-monitoring \
--container-image=ubuntu:18.04 \
--container-restart-policy=always \
--labels=container-vm=cos-stable-81-12871-1185-0 \
--reservation-affinity=any
```


