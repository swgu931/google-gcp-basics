# Howto Create gcp compute instance and Delete them

- ref: https://cloud.google.com/sdk/gcloud/reference/compute/instances/

## Prerequisite
- Install google cloud sdk & create google account

## gcloud init
```
gcloud init
```


```
[Frankfurt]
--region=europe-west3
--zone=europe-west3-a
```

```
PROJECT_ID=lg-cloud-robot-20200731 

gcloud auth login
gcloud config get-value project
gcloud config set project ${PROJECT_ID}
PROJECT_ID=$(gcloud config list project --format "value(core.project)")
gcloud config set compute/zone europe-west3  
gcloud config get-value compute/zone

gcloud compute networks list
gcloud compute networks subnets list --regions=europe-west3
```


## If no network exist in the regions/zone
```
gcloud compute networks create default --subnet-mode=auto

gcloud compute networks list
gcloud compute networks subnets list --regions=europe-west3
```

## In case of no serviceacount 
```
gcloud services disable compute.googleapis.com
gcloud services enable compute.googleapis.com
```

if no serviceaccount exist in the regions/zone
```
YOUR_PROJECT_ID=lg-cloud-robot-20200731

# Create a custom service account
gcloud iam service-accounts create euwest-cloudrobotics-sa \
  --display-name="Cloud Robotics VM Service Account"

# Give it basic permissions
gcloud projects add-iam-policy-binding $YOUR_PROJECT_ID \
  --member="serviceAccount:euwest-cloudrobotics-sa@$YOUR_PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/compute.instanceAdmin.v1"

# Re-run the instance creation with this service account
gcloud compute instances create gcp-instance-euwest-cloudrobotics \
  --image-project=ubuntu-os-cloud \
  --image=ubuntu-2004-focal-v20250313 \
  --zone=europe-west3-a \
  --machine-type=e2-micro \
  --tags=cloud,robotics,cloudrobotics,control,chemnitz \
  --network=default \
  --subnet=default \
  --service-account=euwest-cloudrobotics-sa@$YOUR_PROJECT_ID.iam.gserviceaccount.com \
  --scopes=https://www.googleapis.com/auth/cloud-platform
 ``` 

```
gcloud compute firewall-rules create allow-icmp \
  --network=default \
  --allow=icmp \
  --source-ranges=0.0.0.0/0 \
  --target-tags=chemnitz \
  --description="Allow ping to instances tagged with cloudrobotics"
```


---


# Delete all the resource so as not to pay anything.
- How to remove (delete) all resources so you don't get charged

```
YOUR_PROJECT_ID=lg-cloud-robot-20200731

# Delete the VM instance
gcloud compute instances delete gcp-instance-cloudrobotics \
  --zone=europe-west3-a


# Delete the static external IP (if you reserved one manually)  
gcloud compute addresses list
gcloud compute addresses delete YOUR_IP_NAME --region=europe-west3


# Delete firewall rules (optional)
gcloud compute firewall-rules delete allow-icmp
  
#  
gcloud iam service-accounts delete cloudrobotics-sa@$YOUR_PROJECT_ID.iam.gserviceaccount.com
```
  
