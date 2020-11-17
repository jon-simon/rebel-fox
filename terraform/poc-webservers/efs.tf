resource "aws_efs_file_system" "webservers" {
  creation_token = "poc-webservers"

  tags = {
    Name = "poc-webservers-efs"
  }
}
