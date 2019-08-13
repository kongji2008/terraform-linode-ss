provider "linode" {
    token = "${var.token}"
}

resource "linode_sshkey" "default" {
  label = "andy_kong"
  ssh_key = "${chomp(file("~/.ssh/id_rsa.pub"))}"
}

resource "linode_instance" "bastion" {
    label = "bastion_instance"
    image = "${var.image}"
    region = "${var.region}"
    type = "${var.type}"
    authorized_keys = [ "${linode_sshkey.default.ssh_key}" ]
    root_pass = "${random_password.password.result}"

    private_ip = true
    group = "terraform"
    tags = ["terraform","bastion","shadowsockets"]

    stackscript_id = 566730
    stackscript_data = {
      "password" = "${random_password.password.result}"
    }
}

resource "random_password" "password" {
  length = 16
  special = true
}
