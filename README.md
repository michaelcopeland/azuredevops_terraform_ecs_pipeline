"# azuredevops_terraform_ecs_pipeline" 

This Azure devops pipeline will create resources in AWS ECS (Elastic Container Service) using terraform.

I put this together in response to a test for a DevOps related job. There weren't many resources regarding this when I did this so I hope this helps others out there.

Disclaimer: Before this I've never worked with Azure devops before, in addition, I've only had an introduction to Terraform.

Step 1. You'll need to add Terraform installer to your Azure devops.  
Step 2 [Terraform]. Add 'AWS Toolkit for Azure DevOps' to your Terraform: https://marketplace.visualstudio.com/items?itemName=AmazonWebServices.aws-vsts-tools . This provides the AWS CLI which we'll need to communicate from the Azure devops pipeline to AWS.  
Step 3 [Terraform]. Add your IAM credentials to Terraform. Follow this guide: https://docs.aws.amazon.com/vsts/latest/userguide/aws-cli.html specifically, follow the 'AWS Credentials' section.  
Step 4. [Terraform]. You may need to setup Azure storage for the Terraform state files and such.  
