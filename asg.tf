resource "aws_launch_template" "neo4j_launch_template" {
  name_prefix   = "neo4j_instance"
  image_id      = var.neo4j-ami-list[var.target_region]

  instance_type          = var.instance_type
  key_name               = aws_key_pair.neo4j_ec2_key.id
  vpc_security_group_ids = ["${aws_security_group.neo4j_sg.id}"]

  //iam_instance_profile = "profile-1"

  user_data = base64encode(
    templatefile(
      "${path.module}/test.tftpl",
      {
        installGDS = var.install_gds
        installBloom = var.install_bloom
        gdsKey = var.gds_key
        bloomKey = var.bloom_key
        password = var.neo4j_password
        installAPOC = var.install_apoc
      }
    )
  )

  tags = {
    "Name"      = "${var.env_prefix}-instance"
    "Terraform" = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.env_prefix}-asg-instance"
    }
  }
}

resource "aws_autoscaling_group" "neo4j_asg" {
  vpc_zone_identifier = aws_subnet.neo4j_public_subnet.*.id

  desired_capacity   = 3
  max_size           = 3
  min_size           = 3

  launch_template {
    id      = aws_launch_template.neo4j_launch_template.id
    //version = "$Latest"
  }
}