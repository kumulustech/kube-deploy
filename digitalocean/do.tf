# Create a Virtual Machine

# One can provide the Digital Ocean access token via numerous methods
# including passing a variable (from another file, a file passed from the CLI)
# or as an environment variable: export DIGITALOCEAN_TOKEN='xxxx'
# provider "digitalocean" {
#     token = "${var.do_token}"
# }

#  Provision via external ansible, but create the inventory
resource "digitalocean_droplet" "do-master" {
    image = "ubuntu-14-04-x64"
    name = "do-master"
    region = "sfo1"
    size = "1gb"
    ssh_keys = ["778729"]
#    provisioner "local-exec" {
#      command = "echo ${digitalocean_droplet.do-master.ipv4_address} ansible_connection=ssh ansible_ssh_user=root >> inventory"
#    }
}

resource "digitalocean_droplet" "do-minion-1" {
    image = "ubuntu-14-04-x64"
    name = "do-minion-1"
    region = "sfo1"
    size = "1gb"
    ssh_keys = ["778729"]
}

#  Provision via external ansible, but create the inventory
resource "digitalocean_droplet" "do-minion-2" {
    image = "ubuntu-14-04-x64"
    name = "do-minion-2"
    region = "sfo1"
    size = "1gb"
    ssh_keys = ["778729"]
}

#  Provision via external ansible, but create the inventory
resource "digitalocean_droplet" "do-client-1" {
    image = "ubuntu-14-04-x64"
    name = "do-client-1"
    region = "sfo1"
    size = "1gb"
    ssh_keys = ["778729"]
}

# If you don't already have a domain defined in Digital Ocean

#resource "digitalocean_domain" "opsits-com" {
#    name = "opsits.com"
#}

# Add a pointer to the new IP address
# Note that the default TTYL is 1800 seconds, so it will take
# up to 30 minutes in this enviornment for the record to time out.

resource "digitalocean_record" "do-master" {
    domain = "opsits.com"
    type = "A"
    name = "do-master"
    value = "${digitalocean_droplet.do-master.ipv4_address}"
}

resource "digitalocean_record" "do-minion-1" {
    domain = "opsits.com"
    type = "A"
    name = "do-minion-1"
    value = "${digitalocean_droplet.do-minion-1.ipv4_address}"
}

resource "digitalocean_record" "do-minion-2" {
    domain = "opsits.com"
    type = "A"
    name = "do-minion-2"
    value = "${digitalocean_droplet.do-minion-2.ipv4_address}"
}

resource "digitalocean_record" "do-client-1" {
    domain = "opsits.com"
    type = "A"
    name = "do-client-1"
    value = "${digitalocean_droplet.do-client-1.ipv4_address}"
}
