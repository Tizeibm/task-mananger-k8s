output "control_plane_ip" {
  value       = aws_instance.control_plane.public_ip
  description = "Adresse IP publique du Control Plane"
}

output "worker_ips" {
  value       = aws_instance.worker[*].public_ip
  description = "Adresses IP publiques des Workers"
}

output "database_ip" {
  value       = aws_instance.database.public_ip
  description = "Adresse IP publique de la base de donnees"
}
