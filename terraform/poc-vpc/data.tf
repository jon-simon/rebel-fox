// To avoid duplication, all data sources should be defined in this file.

// returns the current account number
// Example usage: data.aws_ami.default.id
data "aws_caller_identity" "current" {}
