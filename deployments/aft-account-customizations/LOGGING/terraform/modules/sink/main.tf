
terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.20.1"
    }
  }
}


resource "aws_oam_sink" "central_logging_sink" {
  name = local.sink_name
  tags = local.tags
}

resource "aws_oam_sink_policy" "central_logging_sink_policy" {
  sink_identifier = aws_oam_sink.central_logging_sink.id
  policy          = jsonencode(local.sink_policy)
}
