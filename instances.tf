resource "aws_instance" "neo4j_instance" {
  count                  = var.node_count
  //ami                  = data.aws_ami.latest_amazon.id
  ami                    = var.neo4j-ami-list[var.target_region]

  instance_type          = var.instance_type
  key_name               = aws_key_pair.neo4j_ec2_key.id
  subnet_id              = aws_subnet.neo4j_public_subnet[count.index].id
  vpc_security_group_ids = ["${aws_security_group.neo4j_sg.id}"]

  private_ip             = cidrhost("${aws_subnet.neo4j_public_subnet[count.index].cidr_block}", 99)
  
  //iam_instance_profile = aws_iam_instance_profile.neo4j_ssr_ssm_instance_profile.name
  //depends_on = [aws_lb.neo4j_lb]

  user_data = templatefile(
    "${path.module}/test.tftpl",
    {
      installGDS = var.install_gds
      installBloom = var.install_bloom
      gdsKey = var.gds_key
      bloomKey = var.bloom_key
      password = var.neo4j_password
      installAPOC = var.install_apoc
      nodeCount = var.node_count
      
    }
  )

  tags = {
    "Name"      = "${var.env_prefix}instance-${var.availability_zones[count.index]}"
    "Terraform" = true
  }
}


