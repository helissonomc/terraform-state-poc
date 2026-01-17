resource "aws_instance" "web" {
  count         = 1

  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_id

  vpc_security_group_ids = [
    var.security_group_id,
  ]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<h1>Hello World from $(hostname -f)</h1>" | sudo tee /var/www/html/index.html > /dev/null
              sudo amazon-linux-extras enable postgresql14
              sudo yum clean metadata
              sudo yum install -y postgresql
              EOF

  tags = {
    Name = "web-instance-${count.index + 1}"
  }
}
