# cloud-resume-challenge

I created a pet project to enhance my expertise in DevOps, it is called the Cloud Resume Challenge.

- Made my CV with simple HTML code and styled it with basic CSS, it's not so spectacular, but i would like to focus more on the DevOps side of the project rather than the Frontend.
- Registered a domain name with Amazon Route 53.
- Used this solution to create a secure static website for my domain: <https://github.com/aws-samples/amazon-cloudfront-secure-static-site>
- Deployed my Resume online, it can be reached at this address: <https://www.cloudresumezsocc.com>
- Created a DynamoDB database to store the number of visitors
- Wrote a Lambda function, which gets and updates the visitor count in the database
- Set up an REST API Gateway, which triggers the Lambda function when gets a request

Now that I had a working static website which can track and show how many visitors it had, I decided to write the underlying infrastructure in Terraform, but first i created a CI/CD pipeline for my Frontend:

- stored my credentials in Github secrets
- set up a GitHub actions workflow, which copies the website to S3 and invalidates the CloudFront Distribution

After I've done the Frontend, I created the Terraform files for the infrastructure:

- Lambda function with python code inside
- API Gateway
- Dynamodb Table

After creating the infrastructure in Terraform, I updated the workflow to run Terraform init, plan, and apply.

It seemed everything was working, but when I tried to open it in a browser, my website declined the request because of the CORS policy, so I had to set the CORS.

At that part came the second issue: if i modified something in my code and made a push to my repo, the CI/CD pipeline came into operation, but it wanted to build every element of the infrastructure again, because there wasn't any tfstate file in my repo.
Of course the terraform apply didn't work, because the infrastructure was already built, but the state wasn't saved.
I had to look after this, and I found that this problem can be solved with a remote repository, so i created an S3 bucket to store the tfstate file, and a dynamodb table to store the lock.

Now every part of my project works as expected, however there are things that can be done to improve the infrastructure and the CI/CD pipeline.

I plan to keep working on this project in the future, until then: GLHF :D
