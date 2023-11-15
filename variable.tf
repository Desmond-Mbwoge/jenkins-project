variable "aws_ami" {
   type    =  string
   default = "ami-053b0d53c279acc90"
}

variable "instance_type" {
    type    = string
    default = "t2.micro" 
}

variable "region" {
    type    =  string
    default = "us-east-1"
}

variable "key_name" {
    type   = string
    default = "public_key"
  
}