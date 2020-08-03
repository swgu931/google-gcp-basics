# google cloud platform gcp how to basic use

## Using docker google/cloud-sdk not to install google cloud sdk                          
```
$docker run -it --rm -v ~/cloud-workspace/google-gcp-access:/shared:rw google/cloud-sdk:latest /bin/bash
```

## in the shell of docker container 

1. login
```
gcloud auth login
```


2. project create 
```
gcloud projects create lg-cloud-robot-20200731 --set-as-default
```
- not working well so access to web site and create in the site. 


3. GKE cluster create
```
gcloud config set project lg-cloud-robot-20200731     # GCRP-test-prject in lggusewan@googlemail.com
gcloud config set compute/zone asia-northeast3   # Seoul region

gcloud container clusters create swever-cloud --project=lg-cloud-robot-20200731 --cluster-version=1.15.12-gke.2 \
--machine-type=n1-standard-1 \
--num-nodes=1 \
--subnetwork=default
```
- example output

  NAME          LOCATION         MASTER_VERSION  MASTER_IP      MACHINE_TYPE   NODE_VERSION   NUM_NODES  STATUS

  swever-cloud  asia-northeast3  1.15.12-gke.2   34.64.158.235  n1-standard-1  1.15.12-gke.2  3          RUNNING


#### to delete projects
```
gcloud endpoints services delete map.endpoints.second-base-252206.cloud.goog --project=second-base-252206
gcloud endpoints services delete www.endpoints.second-base-252206.cloud.goog --project=second-base-252206
gcloud projects delete second-base-252206
 You can undo this operation for a limited period by running the command below.
     $ gcloud projects undelete second-base-252206
```

==> quota 문제로 에러 발생
```
gcloud compute project-info describe --project lg-cloud-robot-20200731
```
- cpus, In-use IP addresses 의  quota 조정
```
gcloud container clusters describe swever-cloud
```


4. gcloud로 클러스터를 제어할 수 있도록 kubectl 인증정보를 설정
```
gcloud container clusters get-credentials swever-cloud
==> 확인: 
kubectl get nodes  
```
- example output
  root@e1dedd3c0179:/shared# kubectl get nodes
  
  NAME                                          STATUS   ROLES    AGE   VERSION
  
  gke-swever-cloud-default-pool-347ceff4-lckr   Ready    <none>   40m   v1.15.12-gke.2
  
  gke-swever-cloud-default-pool-88f406bb-f3bg   Ready    <none>   40m   v1.15.12-gke.2
  
  gke-swever-cloud-default-pool-e402882d-0w7p   Ready    <none>   40m   v1.15.12-gke.2


5. 웹 브라우저 대시보드에서 확인할 수 있도록...
```
kubectl proxy
```

6. access to http://127.0.0.1:8001

