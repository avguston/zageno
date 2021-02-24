resource "aws_s3_bucket" "zageno_wal" {
  bucket = "zageno-wal"
  acl    = "private"

  versioning {
    enabled = true
  }

}
