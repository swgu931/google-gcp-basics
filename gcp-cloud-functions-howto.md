# GCP Cloud Function howto

## The case of using zip file uploaded in Google Cloud Storage

1. Python, Node.js, Go code 작성
 - main.py must be created in case of python and hanlder function

2. Cloud Function create in Google cloud console 
 - Assuming name of Function-1, trigger : http
 - Function in main.py must be same as the name of Handler function

3. Create deploy.sh in local as following

```
#!/bin/bash

rm -rf ./libs
pip3 install -r requirements.txt -t ./libs

rm *.zip
zip function-1.zip -r ./main.py ./libs

gsutil rm gs://[bucket name]/function-1.zip
gsutil cp ./function-1.zip gs://[bucket name]/

gcloud functions deploy function-1 --runtime=python37 --trigger-http --region=asia-northeast3 --source=gs://[bucket name]/function-1.zip
```
4. Confirm the action in console and the command as the following
```
gcloud functions call function-1 --data='{"message": "hello workd"}' --region=asia-northeast3
```

*Tip
- requrements.txt
```
requests
```
- setup.cfg
```
[install]
prefix=
```
