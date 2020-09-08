# kubernetes(k8s) cluster setup using kubespray & ansible

## 0) Preparation

- k8s operation server 1ea
- k8s master node 3ea
- k8s worker node 1ea
- all host should be running on ubuntu
- all server with closed private network ip address


## 1) operation server SSH key genearation
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
(~/kubespray) pip install -r requirements.txt
```
```
(~/kubespray) cp -rfp inventory/sample inventory/mycluster
(~/kubespray) declare -a IPS=(10.90.65.11 10.90.65.12 10.90.65.13 10.90.65.21)
(~/kubespray) CONFIG_FILE=inventory/mycluster/hosts.ini python3
(~/kubespray) chmod a+x contrib/inventory_builder/inventory.py 
(~/kubespray) contrib/inventory_builder/inventory.py ${IPS[0]}
```

## 3) Setup K8s Cluster server in operation server

vi ./inventory/mycluster/hosts.ini
```
[all]
master01 ansible_host=10.90.65.11 ip=10.90.65.11
master02 ansible_host=10.90.65.12 ip=10.90.65.12
master03 ansible_host=10.90.65.13 ip=10.90.65.13
node01 ansible_host=10.90.65.21 ip=10.90.65.21

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
(~/kubespray) $ ansible-playbook -i ./inventory/mycluster/hosts.ini ./cluster.yml
```
```
master01:~# kubectl get nodes
```
