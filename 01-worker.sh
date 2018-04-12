#!/usr/bin/bash
set -o nounset -o errexit

# https://github.com/kubernetes/kubeadm/issues/202
cat > /etc/systemd/system/kubelet.service.d/10-kublet-extra-args.conf <<EOF
[Service]
Environment="KUBELET_EXTRA_ARGS=--node-ip=${NODE_PRIVATE_IP} --node-labels=kubernetes.io/role=node"
EOF

systemctl daemon-reload

eval $(cat /tmp/kubeadm_join)
systemctl enable docker kubelet