module "vpc" {
    source = "./modules"
    name = "PoC"
    cidr = "100.64.0.0/16"
    #azs= ["ap-northeast-2a","ap-northeast-2c"]
    azs = "ap-northeast-2a"
    public_subnets = "100.64.10.0/24"
    #private_subnets = ["100.64.20.0/24","100.64.21.0/24"]

    tags = {
        "TerraformManaged" = "true"
    }
}

module "ec2" {
    source = "./modules"
    key_name = "test123"
    ami = "ami-03461b78fdba0ff9d"
    instance_type = "t3.small"
    tags = {
        "TerraformManaged" = "true"
    }
}