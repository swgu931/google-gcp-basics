# GKE (Google Kubernetes Engine) setup

1. GKE cluster create
```
gcloud container clusters create swever-cloud --project=${PROJECT_ID} --cluster-version=1.15.12-gke.2 \
--machine-type=n1-standard-1 \
--num-nodes=1 \
--subnetwork=default
```
- example output

  NAME          LOCATION         MASTER_VERSION  MASTER_IP      MACHINE_TYPE   NODE_VERSION   NUM_NODES  STATUS

  swever-cloud  asia-northeast3  1.15.12-gke.2   34.64.158.235  n1-standard-1  1.15.12-gke.2  3          RUNNING


```
gcloud compute project-info describe --project ${PROJECT_ID}
```
```
gcloud container clusters describe swever-cloud
```


2. gcloud로 클러스터를 제어할 수 있도록 kubectl 인증정보를 설정/가져오기
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


3. 웹 브라우저 대시보드에서 확인할 수 있도록...
 
      : ref: https://kubernetes.io/ko/docs/tasks/access-application-cluster/web-ui-dashboard/
```
kubectl apply -f https://raw.githubusercontent.com/kubetm/kubetm.github.io/master/sample/practice/appendix/gcp-kubernetes-dashboard.yaml 
kubectl proxy --port=8001
```

4. access to http://127.0.0.1:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/overview?namespace=default



---
## Follow the below step if you already have project and cluster

```
gcloud auth login
gcloud config set project ${PROJECT_ID}     # project in accountn@googlemail.com
gcloud config set compute/zone asia-northeast3   # Seoul region
gcloud container clusters get-credentials swever-cloud
kubectl get nodes  
```

### to delete projects after finishing project
```
gcloud endpoints services delete map.endpoints.${PROJECT_ID}.cloud.goog --project=${PROJECT_ID}
gcloud endpoints services delete www.endpoints.${PROJECT_ID}.cloud.goog --project=${PROJECT_ID}
gcloud projects delete ${PROJECT_ID}
 You can undo this operation for a limited period by running the command below.
     $ gcloud projects undelete ${PROJECT_ID}
```
