resource "aws_instance" "hardway-controller" { 
    count = 1
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.web_service.id]
    subnet_id = var.public_subnet

    user_data = <<EOF
            #! /bin/bash
            hostnamectl set-hostname controller-${format(count.index)}
    EOF

    tags = {
        Name = "Controller-${format(count.index)}"
    }
}

resource "aws_instance" "hardway-worker" { 
    count = 1
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.web_service.id]
    subnet_id = var.public_subnet

    user_data = <<EOF
            #! /bin/bash
            hostnamectl set-hostname worker-${format(count.index)}
            pod-cidr=10.200.${format(count.index)}.0/24"
    EOF

    tags = {
        Name = "Worker-${format(count.index)}"
    }
}

resource "aws_instance" "hardway-haproxy" { 
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.web_service.id]
    subnet_id = var.public_subnet

    user_data = <<EOF
            #! /bin/bash
            hostnamectl set-hostname haproxy
    EOF

    tags = {
        Name = "haproxy"
    }
}
