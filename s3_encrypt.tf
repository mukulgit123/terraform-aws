resource "aws_s3_bucket" "pci-dss-bucket" {
  bucket = "pci-dss-bucket"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
  }
}

