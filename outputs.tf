output "ssh_commands" {
  value = [  
    for key, value in aws_instance.neo4j_instance[*].public_ip: "ssh -o StrictHostKeyChecking=no -i ${var.private_key_path} ec2-user@${value}"
  ]
}

output "graphDataScienceLicenseKey" {
  value = ${var.graph_data_science_license_key}
}