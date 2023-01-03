output "all_ips" {
  value       =  aws_instance.neo4j_instance[*].public_ip
}

output "key_path" {
  value = var.private_key_path
} 