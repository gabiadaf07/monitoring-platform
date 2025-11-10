output "jenkins_ip" {
  value = aws_instance.jenkins_vm.public_ip
}
