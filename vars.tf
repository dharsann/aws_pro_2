variable "region" {
  default = "ap-south-1"
}

variable "ami" {
  default = "ami-0f2e255ec956ade7f"
}

variable "public_key_path" {
    default = "/home/dharsann/terraform/aws_pro_1/mumbai-region-key-pair.pub"
}

variable "private_key_path" {
    default = "/home/dharsann/terraform/aws_pro_1/mumbai-region-key-pair"
}