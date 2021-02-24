resource "aws_iam_user" "postgres_wal" {
  name = "postgres-wal"
}

resource "aws_iam_user_policy_attachment" "postgres_wal" {
  user       = aws_iam_user.postgres_wal.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_access_key" "postgres_wal" {
  user = aws_iam_user.postgres_wal.name
}