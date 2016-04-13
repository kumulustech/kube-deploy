# Create a Virtual Machine


# If you don't already have a domain defined in Digital Ocean

#resource "digitalocean_domain" "opsits-com" {
#    name = "opsits.com"
#}

# create a master device resoruce in packet.net
resource "packet_device" "ku2-master" {
        hostname = "ku2-master"
        plan = "baremetal_3"
        facility = "ewr1"
	operating_system = "centos_7"
        billing_cycle = "hourly"
        project_id = "4595f2d8-047a-4718-a581-7565657c1bfc"
}

# create a master device resoruce in packet.net
resource "packet_device" "ku2-minion-1" {
        hostname = "ku2-minion-1"
        plan = "baremetal_3"
        facility = "ewr1"
	operating_system = "centos_7"
        billing_cycle = "hourly"
        project_id = "4595f2d8-047a-4718-a581-7565657c1bfc"
}
#resource "packet_device" "ku2-minion-2" {
#        hostname = "ku2-minion-2"
#        plan = "baremetal_3"
#        facility = "ewr1"
#	operating_system = "ubuntu_14_04"
#        billing_cycle = "hourly"
#        project_id = "4595f2d8-047a-4718-a581-7565657c1bfc"
#}
#resource "packet_device" "ku2-minion-3" {
#        hostname = "ku2-minion-3"
#        plan = "baremetal_3"
#        facility = "ewr1"
#	operating_system = "ubuntu_14_04"
#        billing_cycle = "hourly"
#        project_id = "4595f2d8-047a-4718-a581-7565657c1bfc"
#}
#resource "packet_device" "ku2-minion-4" {
#        hostname = "ku2-minion-4"
#        plan = "baremetal_3"
#        facility = "ewr1"
#	operating_system = "ubuntu_14_04"
#        billing_cycle = "hourly"
#        project_id = "4595f2d8-047a-4718-a581-7565657c1bfc"
#}
#resource "packet_device" "ku2-client-1" {
#        hostname = "ku2-client-1"
#        plan = "baremetal_1"
#        facility = "ewr1"
#	operating_system = "ubuntu_14_04"
#        billing_cycle = "hourly"
#        project_id = "4595f2d8-047a-4718-a581-7565657c1bfc"
#}

# Add a pointer to the new IP address
# Note that the default TTYL is 1800 seconds, so it will take
# up to 30 minutes in this enviornment for the record to time out.

resource "digitalocean_record" "ku2-master" {
    domain = "opsits.com"
    type = "A"
    name = "ku2-master"
    value = "${packet_device.ku2-master.network.0.address}"
}

resource "digitalocean_record" "ku2-minion-1" {
    domain = "opsits.com"
    type = "A"
    name = "ku2-minion-1"
    value = "${packet_device.ku2-minion-1.network.0.address}"
}

#resource "digitalocean_record" "ku2-minion-2" {
#    domain = "opsits.com"
#    type = "A"
#    name = "ku2-minion-2"
#    value = "${packet_device.ku2-minion-2.network.0.address}"
#}
#
#resource "digitalocean_record" "ku2-minion-3" {
#    domain = "opsits.com"
#    type = "A"
#    name = "ku2-minion-3"
#    value = "${packet_device.ku2-minion-3.network.0.address}"
#}

#resource "digitalocean_record" "ku2-minion-4" {
#    domain = "opsits.com"
#    type = "A"
#    name = "ku2-minion-4"
#    value = "${packet_device.ku2-minion-4.network.0.address}"
#}

#resource "digitalocean_record" "ku2-client-1" {
#    domain = "opsits.com"
#    type = "A"
#    name = "ku2-client-1"
#    value = "${packet_device.ku2-client-1.network.0.address}"
#}
