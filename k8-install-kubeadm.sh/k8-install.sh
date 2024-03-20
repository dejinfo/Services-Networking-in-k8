K8s-Cluster-Installation-Steps
==============================================

Step1:
Note: Run the below commands as ubuntu user
#Set host name in master  
sudo hostnamectl set-hostname "k8smaster.example.net" 
exec bash

#Set hostname in worker node
sudo hostnamectl set-hostname "k8sworker1.example.net" 
exec bash

##Add the following entries in /etc/hosts file on each node <public-ip> k8smaster.example.net k8smaster
sudo vim  /etc/hosts

13.233.147.251 k8smaster.example.net k8smaster 
65.1.107.119 k8sworker1.example.net k8sworker1 


Step2:Run the common.sh on both master and worker node

sudo sh k8s-common.sh

Note:Whenever script is prompt, Press Enter

Step3:Initialize Kubernetes cluster with Kubeadm command Now, we are all set to initialize Kubernetes cluster. 
Run the following Kubeadm command from the master node only.
Note: Run the below commands as ubuntu user

sudo kubeadm init --control-plane-endpoint=k8smaster.example.net 

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml

kubectl get nodes


Step4: Join both the worker nodes to the cluster, command is already there is output, just copy paste on the worker nodes,
Note: run kubeadm join with sudo

sudo kubeadm join k8smaster.example.net:6443 --token vt4ua6.wcma2y8pl4menxh2 \
--discovery-token-ca-cert-hashsha256:0494aa7fc6ced8f8e7b20137ec0c5d2699dc5f8e616656932ff9173c94962a3


