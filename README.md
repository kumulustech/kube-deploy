## Using Packet.net to deploy a Kubernetes as containers on docker service

This set of tools helps to deploy a Kubernetes (1.2.2 at the moment) service
as Docker containers with a "bootstrap" docker instance (accessible only via
  a socket interface) and a "public" docker instance that is managed by Kubernetes.

It uses the master and worker model in the kubernetes getting started model which
has been modified to support deploying and configuring docker on CentOS as
well as Ubuntu.  CentOS 7 seems to handle Docker service startup differently
than the scripts expect, so modifications were need to ensure that the embedded
Flannel network is properly configured and brought online.

As this system is being built specifically to support testing and validating
databases on containers (and testing different storage) there are some scripts
to support storage manipulation as well (see sfdisk-X.sh).  These scripts will
try to configure various storage, and map them to /dev/nvme* directories. In
the case of iSCSI attached storage at packet, the packet-block-storage-attach
and packet-block-storage-detach scripts need to be used, and a "master" scripts
has not yet been created to format and mount the disks, but it is a trivial
script to create.

There is one file "missing" from this repository, specifically for use with
the terraform script. It is a script that sets the environment variables for
API access to packet.net (servers and eventually storage), and digital ocean (DNS)

Note that other providers could be used for DNS, but digital ocean was convenient
for this initial test effort.

The script (perhaps call it packet_do.api) should looks something like:

#!/bin/bash
echo "this file should be sourced, not run; e.g. \"source $0\""
export PACKET_AUTH_TOKEN=packetauthtokenpacketauthtokenpacketauthtoken
export DIGITALOCEAN_TOKEN=doauthtokendoauthtokendoauthtokendoauthtokendoauthtoken


After that, the process should be:

1) verify that the domain names will work (and if you can keep them as master
  and minion-1 the database scripts will have an easier time being run)

2) create a shared ssh-key for use with the environment:

    ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa_kumulus

The name of the key is important as the ansible expects exactly that name.

2) verify and launch the environment

    cd packet
    source packet_do.api
    terraform plan

If the plan is happy (lots of green, no yellow/red)

    terraform apply

Once the apply completes, you can run ansible and deploy the kubernetes system(s)

    ansible-playbook -i inventory play.yml

That should be all you need.  You should then be able to log into the machines with:

    ssh master.{domain_in_digital_ocean} -i ~/.ssh/id_rsa_kumulus

Replace master with minion-1 should also work, as should ssh between the machines.
