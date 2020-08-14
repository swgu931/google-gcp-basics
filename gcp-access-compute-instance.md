# gcp access compute instance howto

```
gcloud compute instances list
```
```
gcloud compute firewall-rules create --network=NETWORK default-allow-ssh --allow=tcp:22
```
```
gcloud compute ssh gcp-cloud-test --zone=asia-northeast3-a
```
