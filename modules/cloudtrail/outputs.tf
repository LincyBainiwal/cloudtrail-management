output "trail_arn" {
  description = "ARN of the CloudTrail trail"
  value       = aws_cloudtrail.management_trail.arn
}

output "trail_id" {
  description = "ID of the CloudTrail trail"
  value       = aws_cloudtrail.management_trail.id
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket for CloudTrail logs"
  value       = aws_s3_bucket.trail_bucket.bucket
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket for CloudTrail logs"
  value       = aws_s3_bucket.trail_bucket.arn
}
