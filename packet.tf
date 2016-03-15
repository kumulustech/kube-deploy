# Create a Virtual Machine


# If you don't already have a domain defined in Digital Ocean

#resource "digitalocean_domain" "opsits-com" {
#    name = "opsits.com"
#}

# create a master device resoruce in packet.net
resource "packet_device" "kube-master" {
        hostname = "kube-master"
        plan = "baremetal_1"
        facility = "ewr1"
	operating_system = "centos_7"
        billing_cycle = "hourly"
        project_id = "4595f2d8-047a-4718-a581-7565657c1bfc"
}

# create a master device resoruce in packet.net
resource "packet_device" "kube-minion-1" {
        hostname = "kube-minion-1"
        plan = "baremetal_1"
        facility = "ewr1"
	operating_system = "centos_7"
        billing_cycle = "hourly"
        project_id = "4595f2d8-047a-4718-a581-7565657c1bfc"
}

# Add a pointer to the new IP address
# Note that the default TTYL is 1800 seconds, so it will take
# up to 30 minutes in this enviornment for the record to time out.

resource "digitalocean_record" "kube-master" {
    domain = "opsits.com"
    type = "A"
    name = "kube-master"
    value = "${packet_device.kube-master.network.0.address}"
}

resource "digitalocean_record" "kube-minion-1" {
    domain = "opsits.com"
    type = "A"
    name = "kube-minion-1"
    value = "${packet_device.kube-minion-1.network.0.address}"
}


