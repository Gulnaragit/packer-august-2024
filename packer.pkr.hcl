packer {
  required_plugins {
    amazon = {
      version = " >= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "packer" {
  ami_name      = "golden-image {{timestamp}}"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami = "ami-0ebfd941bbafe70c6"
  ssh_username = "ec2-user"
  ssh_private_key_file = "~/.ssh/id_rsa"
  ssh_keypair_name = "packer-key"
  
  ami_regions = [
    "us-east-2",
    "us-west-1"  
    ]
}

build {
  name    = "learn-packer"
  sources = [
    "source.amazon-ebs.packer"
  ]

  provisioner "shell" {
    script = "script.sh"
  }

}
