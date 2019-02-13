data "archive_file" "push_to_bucket_1" {
  type        = "zip"
  source_file = "push_to_bucket_1.py"
  output_path = "push_to_bucket_1.zip"
}

data "archive_file" "push_to_bucket_2" {
  type        = "zip"
  source_file = "push_to_bucket_2.py"
  output_path = "push_to_bucket_2.zip"
}
