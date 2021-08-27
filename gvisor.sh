#!/bin/bash
echo "Install libvirtd,kvm and minikube and  kubectl"
sudo yum -y install epel-release
sudo yum -y install libvirt qemu-kvm virt-install virt-top libguestfs-tools bridge-utils
sudo systemctl start libvirtd
sudo systemctl enable libvirtd
systemctl status libvirtd
sudo usermod -a -G libvirt $(whoami)
wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube-linux-amd64
sudo mv minikube-linux-amd64 /usr/local/bin/minikube
minikube version
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl  /usr/local/bin/
kubectl version --client -o json
echo "Start and enable plugins"
minikube start --container-runtime=containerd  --docker-opt containerd=/var/run/containerd/containerd.sock
minikube addons list -> to list plugins 
minikube addons enable gvisor
minikube addons list
