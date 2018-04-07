#!/usr/bin/bash
set -o nounset -o errexit

kubeadm init \
  --pod-network-cidr=10.244.0.0/16 \
  --apiserver-advertise-address=${MASTER_PRIVATE_IP}\
  --apiserver-cert-extra-sans=${MASTER_PUBLIC_IP}

kubectl --kubeconfig=/etc/kubernetes/admin.conf apply -f /tmp/kube-flannel.yml
systemctl enable docker kubelet

# used to join nodes to the cluster
kubeadm token create --print-join-command > /tmp/kubeadm_join

chown core /etc/kubernetes/admin.conf

# used to setup kubectl
echo Environment=KUBELET_EXTRA_ARGS=--node-ip=${MASTER_PRIVATE_IP} >> /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
systemctl daemon-reload

systemctl restart kubelet
