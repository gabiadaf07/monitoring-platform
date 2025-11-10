variable "key_name" {
  default = "jenkins-key"
}

variable "public_key_path" {
  default = "~/.ssh/id_rsa_jenkins.pub"
}
variable "ami_id" {
  description = "ID-ul imaginii AMI pentru instanța EC2"
  default     = "ami-12345678" # Poți pune orice în LocalStack
}

variable "instance_type" {
  description = "Tipul instanței EC2"
  default     = "t2.micro"
}
