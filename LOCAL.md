## quickstart

1. follow the steps in the README
2. `terraform init`
3. `terraform apply`

Congratulations! You are the proud owner of a kubernets cluster. When the deployment is ready you'll see something like this in the console:

    Apply complete! Resources: 14 added, 0 changed, 0 destroyed.

    Outputs:

    ingress_address_public = 192.241.222.136
    master_address = 10.134.22.222
    ssh_address_public = 192.241.227.187
    worker_addresses = [
        10.134.23.225,
        10.134.25.247,
        10.134.23.79
    ]

you have a `kubeconfig` in `secrets`. try it out:

    kubectl --kubeconfig ./secrets/admin.conf get pods

maybe you want to see some resource reports:

    kubectl --kubeconfig ./secrets/admin.conf top nodes

Be sure to read the [documentation](https://kubernetes.io/);

we've also set up an ssh config for you becuase ssh is proxied behind a firewall. the rules are in `secretes/ssh.conf`. when you are comfortable with those you can copy them to `~/.ssh/conf`. In the meantime, make sure you can ssh to your cluster:

     ssh -F secrets/ssh.conf k8sMaster

the ingress is your http/https endpoint. test it:

    curl $ingress_address_public
