# Google container registry howto

- google-sdk docker run
```
docker run -it --rm --net host -w /shared/ -v /var/run:/var/run:rw -v ~/cloud-workspace/google-gcp-access:/shared:rw google/cloud-sdk:latest /bin/bash
```

- Preparations
```
gcloud auth login
gcloud auth configure-docker
gsutil ls
```
- Enable Container Registry API in google cloud console

- docker tag [SOURCE_IMAGE] [HOSTNAME]/[PROJECT-ID]/[IMAGE]
```
docker tag nginx:latest asia.gcr.io/test-project/nginx:test-1
```
- docker push [HOSTNAME]/[PROJECT-ID]/[IMAGE]
```
docker push asia.gcr.io/test-project/nginx:test-1
```
- gcloud container images list-tags [HOSTNAME]/[PROJECT-ID]/[IMAGE]
```
gcloud container iamges list-tags asia.gcr.io/test-project/nginx:test-1
```

- docker pull [HOSTNAME]/[PROJECT-ID]/[IMAGE]:[TAG]
- docker pull [HOSTNAME]/[PROJECT-ID]/[IMAGE]@[IMAGE_DIGEST]
