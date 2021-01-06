output "vpc_id" {
    value = aws_vpc.main.id
}

output "cidr_block" {
    value = aws_vpc.main.cidr_block
}

output "public_subnet" {
    value = aws_subnet.subnet.id
}