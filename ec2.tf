resource "aws_security_group" "web_service" {
    name = "terraform test"
    vpc_id = aws_vpc.main.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 0 
        to_port =  0
        protocol = "-1"
        cidr_blocks = [var.public_subnets]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "hardway-controller" { 
    count = 3
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.web_service.id]
    subnet_id = aws_subnet.subnet.id

    user_data = <<EOF
            #! /bin/bash
            hostnamectl set-hostname controller-${format(count.index)}
    EOF

    tags = {
        Name = "Controller-${format(count.index)}"
    }
}

resource "aws_instance" "hardway-worker" { 
    count = 3
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.web_service.id]
    subnet_id = aws_subnet.subnet.id

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
    subnet_id = aws_subnet.subnet.id

    user_data = <<EOF
            #! /bin/bash
            hostnamectl set-hostname haproxy
    EOF

    tags = {
        Name = "haproxy"
    }
}

resource "aws_instance" "hardway-management" { 
    ami = var.ami
    instance_type = var.instance_type 
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.web_service.id]
    subnet_id = aws_subnet.subnet.id

    user_data = <<EOF
            #! /bin/bash
            hostnamectl set-hostname management
    EOF

    tags = {
        Name = "management"
    }
}