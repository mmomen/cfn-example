# cfn-example

Sample application using ALB, Lambda and S3 to provide an interface to read data.

## Design

User hits URL to load balancer, which sends to the Lambda function by default, which pulls data from S3 bucket.

### Improvements

* Use Route53 to set up DNS name which points to the ALB DNS name.
* In a more complex setup, consider using a routing policy (failover, latency, etc...)
* Use ALB listener rules to take advantage of multiple lambdas (or other resources) to add, update or delete data. (See commented out example)

## Reliability

Since this comprises of all managed services by AWS, much of the reliability is dependent on AWS.

### Improvements

* If high usage of the Lambda function, must increase the number of concurrent executions (1000 by default, throttling occurs above the set number).
* Dead letter queues can be use to dump errors to an SQS queue to be reprocessed.
* In this case, the lambda function is fairly small. Larger functions may need the timeout increased or broken into multiple lambdas.

## Security

### Improvements

* Use HTTPS with a real certificate.
* Look into WAF to sit in front of ALB and take advantage of various preconfigured rules to prevent attempts at things like SQL injection.

## Scalability

### Improvements

## Reproducibility

* Update values in `bin/deploy.sh` and execute the script with proper AWS creds configured.
* Can created other deploy scripts for specific environments, exporting their region-specific variables, then calling on a more generic `deploy.sh` which executes the sam commands.
* Using SAM to deploy CloudFormation. SAM makes it easier to include/deploy code as well as reference certain IAM policies within CloudFormation.

### Improvements

* Hard-coded bucket name in Lambda code - find a better way to find, or update have the code updated, with the proper bucket name.

## Monitoring

### Improvements

* Monitor duration, errors, dead letter errors, throttles
