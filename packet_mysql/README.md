Deploy Kubernetes to Packet.net
===============================

This directory contains both a Terraform description and a set of Ansible YAML files that, when weilded properly will deploy a master node and 3 minions running the Docker container Kubernetes multi-node environment.

In order to use the Terraform script:
  a) Install terraform (from terraform.io or on a Mac via brew)
  b) set your Packet.net API token as an environment varilable:
    export PACKET_AUTH_TOKEN={get it from https://app.packet.net/portal#/api-keys}
  c) note that we're also using Digital Ocean's DNS service (will move to AWS RT53 but this was convenient), so set your Digital Ocean API Token as well:
    export DIGITALOCEAN_TOKEN={https://cloud.digitalocean.com/settings/api/tokens}
  d) review the script for both host names, and your DO associated DNS domain (opsits.com is likely not yours)
  e) terraform plan
  f) terraform apply
  g) Go get a coffee, this likely takes ~30 minutes
  h) You may have to run terraform again to ensure the DNS entries are updated, as things occasionally time out (Packet.net is great, but not quite at the speed of anticipated cloud deployment these days)

Then, if all goes well, you will need to edit the inventory file to match your newly created hosts (use the FQDN rather than the IP address here).

Finally, ansible-playbook away (yes, I need to make some roles here, all in good  time):

  ansible-playbook -i inventory play.yml

There are still a few issues with the play. If the docker install script ("setup script") doesn't run properly, you should _DELETE_ your environment, and re-create it.  There is a surgical approach, but a phoenix model is much more efficient.

Note that you'll likely want to add additional ssh keys
files:
Debian.yml
  Debian/Ubuntu prerequisites and basic applications

Redhat.yml
  RedHat/CentOS/Fedora prerequisites and basic applications

ap.sh
  Keep having to type: ansible-playbook -i inventory play.yml?  I was getting tired of having to do that...

get_kubectl.sh
  Get the kubectl client.

hosts.yml
  Set up /etc/hosts with the FQDN of all of the hosts deployed

inventory
  The FQDN of the hosts in master or minion mode

keys.yml
  Additional SSH keys

kube_connect.sh
  Set up kubectl to connect to your kubernets cluster, just pass the cluster master IP or resolvable host name.

label_cluster.sh
  This shoudl be run on your master node, to label the high peformance disk machines as such (so that the mongo nodes don't get deployed to the master)

packet.tf
  The terraform description of the enviornment

play.yml
  The main playbook that installs all of the baseline pieces

sfdisk-nvme.sh
  A script to be run on the minions to create and format the NVME disk.

skydns.yaml
  The DNS configuration POD and Service description for the master node.

terraform.tfstate
terraform.tfstate.backup
  The state files for the terraform deployment

ycsb.yml
  The YCSB installation ansible components.
