resource "null_resource" "sftp_setup" {
    depends_on = [aws_instance.sftp-server]
    provisioner "file" {
      source = "script.sh"
      destination = "/home/dharsann/terraform/aws_pro_1/script.sh"
    }
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("/home/dharsann/terraform/aws_pro_1/mumbai-region-key-pair")
      host        = aws_instance.sftp.public_ip
    }
    provisioner "remote-exec" {
        inline = [ "chmod +x /home/dharsann/terraform/aws_pro_1/script.sh",
                    "sudo /home/ec2-user/script.sh"]
    }
}