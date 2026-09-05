resource "aws_security_group" "k8s_sg" {
  name        = "k8s-cluster-sg"
  description = "Regles de securite pour le cluster Kubernetes"
  vpc_id      = aws_vpc.k8s_vpc.id

  # Communication interne totale entre les noeuds du cluster
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  # Acces SSH pour l'administration
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Acces a l'API Kubernetes (Control Plane)
  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Acces NodePort pour l'application Angular et API (Backend)
  ingress {
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Trafic sortant autorise (Telechargement des images Docker, MAJ systeme)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "k8s-security-group" }
}
