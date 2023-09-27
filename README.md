# cloud-resume-challenge

I created a pet project to enhance my expertise in DevOps, it is called the Cloud Resume Challenge.

- Made my CV with simple HTML code and styled it with basic CSS, it's not so spectacular, but i would like to focus more on the DevOps side of the project rather than the Frontend.
- Registered a domain name with Amazon Route 53.
- Used this solution to create a secure static website for my domain: <https://github.com/aws-samples/amazon-cloudfront-secure-static-site>
- Deployed my Resume online, it can be reached at this address: <https://www.cloudresumezsocc.com>
- Created a DynamoDB database to store the number of visitors
- Wrote a Lambda function, which gets and updates the visitor count in the database
- Set up an REST API Gateway, which triggers the Lambda function when gets a request

Now that I had a working static website which can track and show how many visitors it had, I decided to write the underlying infrastructure in Terraform.