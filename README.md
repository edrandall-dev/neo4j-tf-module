# neo4j-tf-module
A terraform module for the installation of an environment on which to run neo4j

## usage

The module can be used by creating a parent module, as follows:

~~~
module "neo4j-environment" {
  source             = "../neo4j-tf-module"
  env_name           = "First Test Neo4j Env"
  vpc_base_cidr      = "192.168.0.0/16"
  env_prefix         = "neo4j-test-mod"
  region             = "us-east-1"
  availability_zones = ["a", "b", "c"]

  graphDatabaseVersion = 5.3.0

  instance_qty  = 3
  instance_type = "t3.micro"
  public_key_path = "~/.ssh/aws-test.pub"
  private_key_path = "~/.ssh/aws-test"
}

output "ssh_commands_for_each_instance" {
  value = [  
    for key, value in module.neo4j-environment.all_ips: "ssh -o StrictHostKeyChecking=no -i ${module.neo4j-environment.key_path} ec2-user@${value}"
  ]
}
~~~

Both AWS and Terraform commands need to be installed and properly configured before deploying.