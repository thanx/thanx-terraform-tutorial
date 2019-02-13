data "aws_iam_policy_document" "sns_policy" {
  statement {
    effect    = "Allow"

    principals {
      identifiers = ["*"]
      type = "AWS"
    }

    actions   = [
      "SNS:Publish"
    ]

    resources = [
      "arn:aws:sns:us-east-1:*:s3_fanout_demo"
    ]

    condition = {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = [
        "${aws_s3_bucket.source-bucket-demo.arn}"
      ]
    }

  }
}

resource "aws_sns_topic" "s3_fanout_demo" {
  name   = "s3_fanout_demo"
  policy = "${data.aws_iam_policy_document.sns_policy.json}"
}

resource "aws_sns_topic_subscription" "topic_lambda_sync_bucket_1" {
  topic_arn = "${aws_sns_topic.s3_fanout_demo.arn}"
  protocol  = "lambda"
  endpoint  = "${aws_lambda_function.source_to_target_1_sync.arn}"
}

resource "aws_sns_topic_subscription" "topic_lambda_sync_bucket_2" {
  topic_arn = "${aws_sns_topic.s3_fanout_demo.arn}"
  protocol  = "lambda"
  endpoint  = "${aws_lambda_function.source_to_target_2_sync.arn}"
}
