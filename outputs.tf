output "ssh_commands_for_each_instance" {
  value = [  
    for key, value in aws_instance.neo4j_instance[*].public_ip: "ssh -o StrictHostKeyChecking=no -i ${var.private_key_path} ec2-user@${value}"
  ]
}