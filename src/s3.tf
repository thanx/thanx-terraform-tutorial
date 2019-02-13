resource "aws_s3_bucket" "source-bucket-demo" {
  bucket = "source-bucket-demo"
  acl    = "private"

  tags   = {
    Name = "Source bucket"
  }
}

resource "aws_s3_bucket" "target-bucket-one" {
  bucket = "target-bucket-one"
  acl    = "private"

  tags   = {
    Name = "Target bucket 1"
  }
}

resource "aws_s3_bucket" "target-bucket-two" {
  bucket = "target-bucket-two"
  acl    = "private"

  tags   = {
    Name = "Target bucket 2"
  }
}

resource "aws_s3_bucket_notification" "object_create_sns_demo" {
  bucket = "${aws_s3_bucket.source-bucket-demo.id}"

  topic {
    topic_arn = "${aws_sns_topic.s3_fanout_demo.arn}"
    events    = ["s3:ObjectCreated:*"]
  }
}
