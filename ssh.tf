resource "aws_key_pair" "ssh_key" {
    key_name   = "my_ssh_key"
    #public_key = file(var.public_key)
    public_key = var.public_key
    tags = {
        Name = "MySSHKey2"
    }
  
}