# roadtomiddle_aws_networking

Just a network configuraion example with high customization capability.

## How to use it

In order to use this module, declare it in your manifest and set values to be passed.

### Usage example
Before using the module, make sure that [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) is installed on your machine. 

Let's say, we need a network configuration with 1 public subnet, 1 private subnet, a custom name prefix for each resource, a number of opened ports in your security group, and CIDR blocks of your choice. In such a case, your module declaration in a manifest should look like this or similar:

 ```
module "aws-networking" {
  source                   = "../modules/roadtomiddle_aws_networking"
  common_name              = var.common_name
  vpc_cidr                 = "192.168.0.0/16"
  public_subnet_cidr_list  = ["192.168.1.0/24"]
  private_subnet_cidr_list = ["192.168.2.0/24"]
  security_group_ports     = ["9090", "22"]
}
 ```
 
 In case no values provided to the module, the default ones will be taken from [variables.tf file](https://github.com/1tacticalretard/road_to_middle/blob/master/terraform/modules/roadtomiddle_aws_networking/variables.tf) of the module.

Feel refer to the module resources in a similar manner:
```
module.<name of module>.<output value to be referred to>
```

Here you may see the [list of outputs](https://github.com/1tacticalretard/road_to_middle/blob/master/terraform/modules/roadtomiddle_aws_networking/outputs.tf) you may feel free to refer to. Use any of the present ones or add your own.

Example of usage:
```
subnet_id              = module.aws-networking.public_subnet_ids[0]
```
