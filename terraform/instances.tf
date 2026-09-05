data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Identifiant officiel de Canonical (Ubuntu)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_key_pair" "k8s_ssh_key" {
  key_name   = "k8s-key"
  public_key = file("~/.ssh/k8s-key.pub")
}

resource "aws_instance" "control_plane" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "c7i-flex.large" # 2 vCPU, 4 Go RAM - Idéal pour etcd
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]
  key_name               = "k8s-key" # Ta clé SSH pour te connecter

  root_block_device {
    volume_size = 20
    volume_type = "gp3" # Standard actuel : performant et économique
  }

  tags = { Name = "k8s-control-plane" }
}

resource "aws_instance" "worker" {
  count                  = 3 # Terraform créera 3 instances identiques !
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.small"
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]
  key_name               = "k8s-key"

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  tags = { Name = "k8s-worker-${count.index + 1}" } # Nommera worker-1, worker-2, etc.
}

resource "aws_instance" "database" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]
  key_name               = "k8s-key"

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  tags = { Name = "k8s-postgres-db" }
}
