terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"  # Reemplazar con la región AWS deseada por tu profesor
}

resource "aws_s3_bucket" "bucket" {
  bucket = "pedramsstaticbucket-eu"  # Nombre único para el bucket, ajustar según sea necesario
  acl    = "public-read"

  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket_website_configuration" "static_website" {
  bucket = aws_s3_bucket.bucket.bucket

  routing_rules = jsonencode([
    {
      condition = {
        http_error_code_returned_equals = "404"
        key_prefix_equals              = "index.html"
      }
      redirect_rule = {
        redirect_type = "INDEX_DOCUMENT"
      }
    }
  ])
}

resource "null_resource" "sync_static" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "aws s3 sync static/ s3://${aws_s3_bucket.bucket.bucket} --acl public-read --delete"
  }
}

resource "aws_instance" "app_server" {
  ami                         = "ami-053b0d53c279acc90"
  instance_type               = "t2.micro"
  key_name                    = "appmovilllave"  # Nombre de la clave EC2, ajustar según sea necesario
  vpc_security_group_ids      = ["sg-0c10aa1a9c8989464"]  # ID del grupo de seguridad, ajustar según sea necesario
  associate_public_ip_address = true
  
  provisioner "file" {
    source      = "Aplicacion.tar.gz"  # Asegurar que el archivo Aplicacion.tar.gz existe y está en la misma carpeta que este script de Terraform
    destination = "/home/ubuntu/Aplicacion.tar.gz"
  }

  provisioner "remote-exec" {
    inline = [
      "tar -xvf /home/ubuntu/Aplicacion.tar.gz",
      "sudo /home/ubuntu/Aplicacion/script.sh",
    ]
  }

 connection {
  type        = "ssh"
  user        = "ubuntu"
  private_key = file("./appmovilllave.pem")  # Asegurar que la clave privada existe y está en la misma carpeta que este script de Terraform
  host        = self.public_ip
}

  tags = {
    Name = "EjemploCsalon6"
  }
}
