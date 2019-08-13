output "linode_public_ip" {
    value = "${linode_instance.bastion.ip_address}"
}

output "linode_private_ip" {
    value = "${linode_instance.bastion.private_ip_address}"
}

output "root_password" {
    value = "${random_password.password.result}"
}
