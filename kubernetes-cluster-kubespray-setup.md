# kubernetes(k8s) cluster setup using kubespray & ansible

## 0) Preparation

- k8s operation server 1ea
- k8s master node 3ea
- k8s worker node 1ea
- all host should be running on ubuntu
- all server with closed private network ip address
- setup '--preemptible' optino to reduce GCP cost
- --source-snapshot would be different
```
gcloud compute instances create op-server --source-snapshot=https://compute.googleapis.com/compute/v1/projects/cloud-test/global/snapshots/snapshot-cloud-test \ \
--zone=asia-northeast3-a --machine-type=n1-standard-2 --preemptible --tags=nav2-port,nav2-port-snd,socket-test,socket-test-send 

gcloud compute instances create master01 --source-snapshot=https://compute.googleapis.com/compute/v1/projects/cloud-test/global/snapshots/snapshot-cloud-test \ \
--zone=asia-northeast3-a --machine-type=n1-standard-2 --preemptible --tags=nav2-port,nav2-port-snd,socket-test,socket-test-send 

gcloud compute instances create master02 --source-snapshot=https://compute.googleapis.com/compute/v1/projects/cloud-test/global/snapshots/snapshot-cloud-test \ \
--zone=asia-northeast3-a --machine-type=n1-standard-2 --preemptible --tags=nav2-port,nav2-port-snd,socket-test,socket-test-send 

gcloud compute instances create master03 --source-snapshot=https://compute.googleapis.com/compute/v1/projects/cloud-test/global/snapshots/snapshot-cloud-test \
--zone=asia-northeast3-a --machine-type=n1-standard-2 --preemptible --tags=nav2-port,nav2-port-snd,socket-test,socket-test-send 

gcloud compute instances create node01 --source-snapshot=https://compute.googleapis.com/compute/v1/projects/cloud-test/global/snapshots/snapshot-cloud-test \
--zone=asia-northeast3-a --machine-type=n1-standard-2 --preemptible --tags=nav2-port,nav2-port-snd,socket-test,socket-test-send 
```


## 1) operation server SSH key genearation (op-server)
```
$ ssh-keygen -t rsa
```
ssh-rsa AAAXXXXXXX...

```
$ (root@master01) echo "ssh-rsa AAAXXXXXXX..." >> ~/.ssh/authorized_keys
$ (root@master02) echo "ssh-rsa AAAXXXXXXX..." >> ~/.ssh/authorized_keys
$ (root@master03) echo "ssh-rsa AAAXXXXXXX..." >> ~/.ssh/authorized_keys
$ (root@node01) echo "ssh-rsa AAAXXXXXXX..." >> ~/.ssh/authorized_keys
```

## 2) enable IPv4 forwarding in each server
$ vi /etc/sysctl.conf
```
net.ipv4.ip_forward=1
```
reboot
or
```
$ sysctl -w net.ipv4.ip_forward=1
```

## 3) Install kubesprary in operation server
```
pip install ansible netaddr
git clone https://github.com/kubernetes-sigs/kubespray
cd kubespray && git checkout release-2.11

# Install dependencies from ``requirements.txt``
(~/kubespray) pip3 install -r requirements.txt
```
```
cd ~/kubespray

# Copy ``inventory/sample`` as ``inventory/mycluster``
cp -rfp inventory/sample inventory/mycluster

# Update Ansible inventory file with inventory builder
declare -a IPS=(10.90.65.11 10.90.65.12 10.90.65.13 10.90.65.21)
CONFIG_FILE=inventory/mycluster
chmod a+x contrib/inventory_builder/inventory.py 
python3 contrib/inventory_builder/inventory.py ${IPS[0]}
```

## 3) Setup K8s Cluster server in operation server

vi ./inventory/mycluster/hosts.ini
```
[all]
master01 ansible_host=10.90.65.11 # ip=10.90.65.11
master02 ansible_host=10.90.65.12 # ip=10.90.65.12
master03 ansible_host=10.90.65.13 # ip=10.90.65.13
node01 ansible_host=10.90.65.21 # ip=10.90.65.21

[kube-master]
master01
master02
master03

[kube-node]
node01

[etcd]
master01
master02
master03

[k8s-cluster:children]
kube-node
kube-master

[calico-rr]

[vault]
```

## 4) Setup a variety of K8s parameter and environment in operation server

vi ./inventory/mycluster/group_vars/k8s-cluster/k8s-cluster.yml
```
...
kube_version: v1.15.11
...
```

vi ./inventory/mycluster/group_vars/k8s-cluster/addons.yml
```
...
dashboard_enabled: true
...
```

## 5) Install Cluster 

```
# Deploy Kubespray with Ansible Playbook - run the playbook as root
# The option `--become` is required, as for example writing SSL keys in /etc/,
# installing packages and interacting with various systemd daemons.
# Without --become the playbook will fail to run!

(~/kubespray) $ ansible-playbook -i ./inventory/mycluster/hosts.ini  --become --become-user=root ./cluster.yml
```
```
master01:~# kubectl get nodes
```
