data "aws_iam_policy_document" "move_object" {
  statement {
    effect    = "Allow"
    actions   = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:*:*:*"
    ]
  }

  statement {
    effect    = "Allow"
    actions   = [
      "s3:GetObject"
    ]
    resources = [
      "${aws_s3_bucket.source-bucket.arn}/*"
    ]
  }

  statement {
    effect    = "Allow"
    actions   = [
      "s3:PutObject"
    ]
    resources = [
      "${aws_s3_bucket.target-bucket-one.arn}/*",
      "${aws_s3_bucket.target-bucket-two.arn}/*"
    ]
  }
}

data "aws_iam_policy_document" "lambda_sync_execution_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "lambda_sync_permissions" {
  name   = "lambda_sync_permissions"
  role   = "${aws_iam_role.source_to_target_sync.id}"
  policy = "${data.aws_iam_policy_document.move_object.json}"
}

resource "aws_iam_role" "source_to_target_sync" {
  name               = "source_to_target_sync"
  assume_role_policy = "${data.aws_iam_policy_document.lambda_sync_execution_policy.json}"
}
