resource "random_id" "key_pair_name" {
  byte_length = 4
  prefix      = "key-${var.env_prefix}"
}

resource "aws_key_pair" "neo4j_ec2_key" {
  key_name   = random_id.key_pair_name.hex
  public_key = file(var.public_key_path)

  tags = {
    "Name"      = "${var.env_prefix}-neo4j-ec2-key"
    "Terraform" = true
  }
}
