resource "aws_security_group" "web_service" {
    name = "terraform test"
    vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "ssh" {
    from_port = 22
    to_port = 22
    protocol = "ssh"
    cidr_blocks = ["0.0.0.0/0"]
    type = "ingress"
    security_group_id = aws_security_group.web_service.id
}

resource "aws_security_group_rule" "inbound_vpc" {
    from_port = 0
    to_port =  0
    protocol = "-1"
    cidr_blocks = [var.cidr_block]
    type = "ingress"
    security_group_id = aws_security_group.web_service.id
}

resource "aws_security_group_rule" "outbound_vpc" {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    type = "egress"
    security_group_id = aws_security_group.web_service.id
}