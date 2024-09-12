resource "aws_instance" "test-server" {
ami = "ami-0e86e20dae9224db8"
instance_type= "t2.micro"
key_name = "JEN"
vpc_security_group_id = ["sg-06cdc668f87dca87c"]
connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("./JEN.pem")
    host = self.public_ip
    }
provisioner "remote-exec" {
    inline = ["echo 'wait to start the instance' "]
}
tags = {
    Name = "test-server"
    }
provisioner "local-exec" {
    command = "echo ${aws_instance.test-server.public_ip} > inventory"
    }
provisioner "local-exec" {
    command = "ansible-playbook /var/lib/jenkins/workspace/Banking-finance/terraform-files/ansibleplaybook.yml"
    }
}
