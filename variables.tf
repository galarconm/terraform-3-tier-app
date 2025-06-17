variable "public_key" {
    description = "The public SSH key for EC2 instances"
    type = string
    default     = ""
}
variable "region" {}
variable "bucket" {}