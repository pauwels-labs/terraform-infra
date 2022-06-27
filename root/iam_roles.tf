resource "aws_iam_role" "terraform_backend" {
  name = "TerraformBackend"
  assume_role_policy = data.aws_iam_policy_document.terraform_backend_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "terraform_backend" {
  role = aws_iam_role.terraform_backend.name
  policy_arn = aws_iam_policy.grant_decrypted_rw_on_terraform_backend_bucket.arn
}

resource "aws_iam_role" "root_administrator" {
  name = "RootAdministrator"
  assume_role_policy = data.aws_iam_policy_document.root_administrator_assume_role_policy.json  
}

resource "aws_iam_role_policy_attachment" "root_administrator" {
  role = aws_iam_role.root_administrator.name
  policy_arn = data.aws_iam_policy.administrator_access.arn
}
