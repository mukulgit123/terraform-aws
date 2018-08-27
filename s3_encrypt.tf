resource "aws_s3_bucket" "pci_dss_bucket" {
  bucket = "pci_dss_bucket"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
  }
}

