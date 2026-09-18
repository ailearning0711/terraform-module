resource "aws_instance" "webserver" {
  ami             = var.amiid
  instance_type   = var.machinetype
  vpc_security_group_ids = [aws_security_group.global-sg-2021.id]
  key_name        = var.keyname

  tags = {
    Name = var.mytag
  }
}

resource "aws_ebs_volume" "data_disk" {
  availability_zone = aws_instance.webserver.availability_zone
  size = var.ebs_size
  type = var.ebs_type

  tags = {
    Name = var.volume
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = var.device_name
  volume_id   = aws_ebs_volume.data_disk.id
  instance_id = aws_instance.webserver.id
}
