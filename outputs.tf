output "ssh_commands" {
  value = [  
    for key, value in aws_instance.neo4j_instance[*].public_ip: "ssh -o StrictHostKeyChecking=no -i ${var.private_key_path} ec2-user@${value}"
  ]
}

output "install_gds_output" {
  value = var.install_gds
}

output "install_bloom_output" {
  value = var.install_bloom
}

output "gds_key_output" {
  value = var.gds_key
}

output "bloom_key_output" {
  value = var.bloom_key
}

output "neo4j_password_output" {
  value = var.neo4j_password
}