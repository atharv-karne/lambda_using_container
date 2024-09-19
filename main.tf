provider "aws" {
  region= "ap-south-1"
}

resource "aws_lambda_function" "addition_function" {
  function_name = "addition_function"
  timeout = 30
  image_uri = var.ecr_uri
  package_type = "Image"

  role = "arn:aws:iam::730335267178:role/service-role/addition-program-role-gm8plars"
}