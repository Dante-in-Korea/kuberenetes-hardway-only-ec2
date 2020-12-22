module "vpc" {
    source = "/home/ec2-user/hardway/module"
    name = "PoC"
    cidr = "100.64.0.0/16"
    #azs= ["ap-northeast-2a","ap-northeast-2c"]
    azs= "ap-northeast-2a"
    public_subnets = "100.64.10.0/24"
    #private_subnets = ["100.64.20.0/24","100.64.21.0/24"]

    tags = {
        "TerraformManaged" = "true"
    }
}
