resource "aws_lambda_function" "source_to_target_1_sync" {
  function_name    = "source_to_target_1_sync"
  filename         = "${data.archive_file.push_to_bucket_1.output_path}"
  source_code_hash = "${data.archive_file.push_to_bucket_1.output_base64sha256}"
  role             = "${aws_iam_role.source_to_target_sync.arn}"
  handler          = "push_to_bucket_1.lambda_handler"
  runtime          = "python2.7"
}

resource "aws_lambda_function" "source_to_target_2_sync" {
  function_name    = "source_to_target_2_sync"
  filename         = "${data.archive_file.push_to_bucket_2.output_path}"
  source_code_hash = "${data.archive_file.push_to_bucket_2.output_base64sha256}"
  role             = "${aws_iam_role.source_to_target_sync.arn}"
  handler          = "push_to_bucket_2.lambda_handler"
  runtime          = "python2.7"
}

resource "aws_lambda_permission" "with_sns_1" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.source_to_target_1_sync.function_name}"
  principal     = "sns.amazonaws.com"
  source_arn    = "${aws_sns_topic.s3_fanout_demo.arn}"
}

resource "aws_lambda_permission" "with_sns_2" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.source_to_target_2_sync.function_name}"
  principal     = "sns.amazonaws.com"
  source_arn    = "${aws_sns_topic.s3_fanout_demo.arn}"
}
