provider "aws" {
    region = "ap-northeast-2"
}

resource "aws_vpc" "main" {
    cidr_block = "${var.cidr}"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = "Terraform-101"
    }
}

resource "aws_subnet" "subnet" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.public_subnets}"
    map_public_ip_on_launch = true
    availability_zone  = "${var.azs}"

    tags = "${merge(var.tags, map("Name", format("%s-public-%s", var.name, substr("${var.azs}", 13, 2))))}"

}

resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.main.id}"

    tags = {
        Name = "main"
    }
}

resource "aws_route_table" "route_table" {
    vpc_id = "${aws_vpc.main.id}"
    tags = {
        Name = "main"
    }
}

resource "aws_route" "default-route" {
    route_table_id = aws_route_table.route_table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "route_table_association_1" {
    count = "${length(var.public_subnets)}"
    subnet_id = aws_subnet.subnet.id
    route_table_id = aws_route_table.route_table.id
}
