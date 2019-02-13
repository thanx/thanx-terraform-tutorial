# thanx-terraform-tutorial
This project hosts the code that accompanies the Serverless Data Processing with Terraform tutorial.

## Development
This project requires an AWS count with IAM privileges (the free tier will suffice) as well as the [Terraform CLI][1]. If you've setup Homebrew, you can use that instead:
```bash
$ brew install terraform
```
Once you've cloned the repository, make sure to add your AWS access key ID/secret to the `.credentials` file. Then, you can load the keys into your path and initialize the Terraform environment:
```bash
$ source .credentials
$ cd src
$ terraform init
```
You can verify what resources will be created by checking the execution plan:
```bash
$ terraform plan
```

[1]: https://learn.hashicorp.com/terraform/getting-started/install.html
