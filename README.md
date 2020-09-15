# google cloud platform gcp how to basic use

 - ref : 도커/쿠버네티스를 활용한 컨테이너 개발 실전 입문
 - All source used in this folder come from the ref.
 - gcloud : https://cloud.google.com/sdk/gcloud/reference 
 - gsutil : https://cloud.google.com/storage/docs/gsutil/


## Using docker google/cloud-sdk not to install google cloud sdk                          
```
$docker run -it --rm --net host -v ~/cloud-workspace/google-gcp-access:/shared:rw google/cloud-sdk:latest /bin/bash
```

## in the shell of docker container 

1. login
```
gcloud auth login
```


2. project create or set configuration
```
gcloud projects create project-cloud-test --set-as-default
```
- if not working well, then access to web site and create in the site directly

```
gcloud config set project project-cloud-test     # project in accountn@googlemail.com
gcloud config set compute/zone asia-northeast3   # Seoul region

```
3. GKE cluster create
```
gcloud container clusters create swever-cloud --project=project-cloud-test --cluster-version=1.15.12-gke.2 \
--machine-type=n1-standard-1 \
--num-nodes=1 \
--subnetwork=default
```
- example output

  NAME          LOCATION         MASTER_VERSION  MASTER_IP      MACHINE_TYPE   NODE_VERSION   NUM_NODES  STATUS

  swever-cloud  asia-northeast3  1.15.12-gke.2   34.64.158.235  n1-standard-1  1.15.12-gke.2  3          RUNNING


```
gcloud compute project-info describe --project project-cloud-test
```
```
gcloud container clusters describe swever-cloud
```


4. gcloud로 클러스터를 제어할 수 있도록 kubectl 인증정보를 설정/가져오기
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
 
      : ref: https://kubernetes.io/ko/docs/tasks/access-application-cluster/web-ui-dashboard/
```
kubectl apply -f https://raw.githubusercontent.com/kubetm/kubetm.github.io/master/sample/practice/appendix/gcp-kubernetes-dashboard.yaml 
kubectl proxy --port=8001
```

6. access to http://127.0.0.1:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/overview?namespace=default



---
## Follow the below step if you already have project and cluster

```
gcloud auth login
gcloud config set project project-cloud-test     # project in accountn@googlemail.com
gcloud config set compute/zone asia-northeast3   # Seoul region
gcloud container clusters get-credentials swever-cloud
kubectl get nodes  
```

### to delete projects after finishing project
```
gcloud endpoints services delete map.endpoints.project-cloud-test.cloud.goog --project=project-cloud-test
gcloud endpoints services delete www.endpoints.project-cloud-test.cloud.goog --project=project-cloud-test
gcloud projects delete project-cloud-test
 You can undo this operation for a limited period by running the command below.
     $ gcloud projects undelete project-cloud-test
```
