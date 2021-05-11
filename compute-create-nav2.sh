
gcloud beta compute --project=${PROJECT_ID} instances create-with-container cloud-nav2 \
--zone=asia-northeast3-a --machine-type=n1-standard-1 --subnet=default --network-tier=PREMIUM \ 
--metadata=google-logging-enabled=true --maintenance-policy=MIGRATE \
--service-account=60051663133-compute@developer.gserviceaccount.com \
--scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
--image=cos-stable-81-12871-1185-0 --image-project=cos-cloud --boot-disk-size=10GB --boot-disk-type=pd-standard \
--boot-disk-device-name=cloud-nav2 --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring \
--container-image=robot.ainize.ai/cloud_nav2:1.4.0-r4 --container-restart-policy=always \
--labels=container-vm=cos-stable-81-12871-1185-0 --reservation-affinity=any