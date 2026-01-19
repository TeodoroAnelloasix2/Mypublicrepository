resource "local_file" "inventory" {
  content  = <<EOF
[servers]
${join("\n", [for srv in aws_instance.servers : "${srv.public_ip}"])}
    EOF
  filename = "${path.module}/inventory.ini"
}
