output "instance_ips" {
  description = "dinamcally display and dinamcally store server's public ip "
  value       = [for srv in aws_instance.servers : srv.public_ip]
}
