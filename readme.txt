# using docker to google access
# 2020.07.31
ref: https://github.com/swgu931/google-gcp-basics


google/cloud-sdk                           latest              2bd84e1eea3c        3 weeks ago         2.04GB


docker run -it --rm -v ~/cloud-workspace/google-gcp-access:/shared:rw google/cloud-sdk:latest /bin/bash



# login

gcloud auth login

gcloud projects listi
gcloud projects cheet-sheet
gcloud compute instances list


# project create 

gcloud projects create lg-cloud-robot-20200731 --set-as-default
  : not working well so access to web site and create in the site. 


# GKE cluster create

gcloud config set project lg-cloud-robot-20200731     # GCRP-test-prject in lggusewan@googlemail.com
gcloud config set compute/zone asia-northeast3   # Seoul region


gcloud container clusters create swever-cloud --project=lg-cloud-robot-20200731 --cluster-version=1.15.12-gke.2 \
--machine-type=n1-standard-1 \
--num-nodes=3 \
--subnetwork=default





# to delete projects
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
*cpus, In-use IP addresses 의  quota 조정

gcloud container clusters describe swever-cloud

# gcloud로 클러스터를 제어할 수 있도록 kubectl 인증정보를 설정
gcloud container clusters get-credentials swever-cloud

==> 확인: kubectl get nodes

# 웹 브라우저 대시보드에서 확인할 수 있도록...


kubectl apply -f https://raw.githubusercontent.com/kubetm/kubetm.github.io/master/sample/practice/appendix/gcp-kubernetes-dashboard.yaml 
kubectl proxy --port=8001

: access to 
http://127.0.0.1:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/overview?namespace=default












