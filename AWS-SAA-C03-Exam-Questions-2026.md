# AWS Certified Solutions Architect Associate (SAA-C03) Exam Questions & Answers 2026

## Exam Overview

| Item | Details |
|------|---------|
| Exam Code | SAA-C03 |
| Duration | 130 minutes |
| Questions | 65 |
| Passing Score | 720/1000 (~72%) |
| Cost | $150 USD |
| Format | Multiple choice, scenario-based |

---

## Exam Domains

| Domain | Weight |
|--------|--------|
| Design Secure Architectures | 30% |
| Design Resilient Architectures | 26% |
| Design High-Performing Architectures | 24% |
| Design Cost-Optimized Architectures | 20% |

---

## Question 1: Global Data Aggregation

**Scenario:** A company collects data for temperature, humidity, and atmospheric pressure in cities across multiple continents. The average volume of data that the company collects from each site daily is 500 GB. Each site has a high-speed Internet connection. The company wants to aggregate the data from all these global sites as quickly as possible in a single destination.

**Options:**
- A. Upload the data from each site directly to an Amazon S3 bucket in the closest Region. Use S3 Transfer Acceleration to accelerate the upload.
- B. Upload the data from each site to an Amazon EC2 instance in the closest Region. Store the data in an Amazon S3 bucket.
- C. Set up AWS DataSync to transfer the data from each site to an S3 bucket.
- D. Use AWS Storage Gateway to upload the data to an S3 bucket.

**Answer: A**

**Explanation:** S3 Transfer Acceleration utilizes Amazon CloudFront's globally distributed edge locations to accelerate uploads. For large volumes of data from multiple global sites with high-speed internet, this provides the fastest path to aggregate data in S3.

---

## Question 2: Log Analysis with On-Demand Queries

**Scenario:** A company needs the ability to analyze the log files of its proprietary application. The logs are stored in JSON format in an Amazon S3 bucket. Queries will be simple and will run on-demand.

**Options:**
- A. Use Amazon Redshift to load all the content into one place and run the SQL queries as needed.
- B. Use Amazon Athena directly with Amazon S3 to run the queries as needed.
- C. Use Amazon Elasticsearch to index and query the log data.
- D. Use an API Gateway integration to send a message to an Amazon SQS queue.

**Answer: B**

**Explanation:** Amazon Athena is a serverless query service that allows you to analyze data in S3 using standard SQL. It's perfect for on-demand simple queries on JSON-formatted logs without needing to load or transform the data.

---

## Question 3: S3 Bucket Access Restriction

**Scenario:** A company that manages multiple AWS accounts for different departments through AWS Organizations wants to restrict access to an S3 bucket containing project reports to only users from accounts within the organization.

**Options:**
- A. Add the `aws:PrincipalOrgID` global condition key to the S3 bucket policy with a reference to the organization ID.
- B. Creating an organizational unit (OU) for each department and adding the `aws:PrincipalOrgPaths` global condition key to the S3 bucket policy.
- C. Using AWS CloudTrail to monitor organization events and updating the S3 bucket policy accordingly.
- D. Tagging each user who needs access to the S3 bucket and adding the `aws:PrincipalTag` global condition key.

**Answer: A**

**Explanation:** The `aws:PrincipalOrgID` condition key restricts access to only principals from accounts in the specified AWS Organization. This is the simplest and most maintainable solution for organization-wide bucket access control.

---

## Question 4: API Performance Optimization

**Scenario:** A company recently deployed a RESTful API with Amazon API Gateway and AWS Lambda. The company uses API Gateway and Lambda for processing.

**Options:**
- A. Increase the Lambda memory size to improve performance.
- B. Enable API Gateway caching to reduce Lambda invocations.
- C. Add Lambda reserved concurrency.
- D. Enable Lambda Power Tuning.

**Answer: B**

**Explanation:** API Gateway caching stores API responses and reduces the number of Lambda invocations, improving performance and reducing costs for repeated identical requests.

---

## Question 5: Windows File Server Migration

**Scenario:** A company that is moving its Windows workloads to AWS and has more than 5 TB of file data on Windows file servers.

**Options:**
- A. Use AWS Storage Gateway File Gateway.
- B. Use AWS DataSync for migration.
- C. Use Amazon S3 File Gateway.
- D. Use Amazon FSx for Windows File Server.

**Answer: D**

**Explanation:** Amazon FSx for Windows File Server provides fully managed Windows file servers with SMB support, ideal for Windows workloads with existing file shares.

---

## Question 6: Document Conversion Application

**Scenario:** A company runs its infrastructure on AWS and has a registered base of 700,000 users. The company needs to create a product that converts large PDF files to JPG image files. The PDF files average 5 MB in size.

**Options:**
- A. Save the PDF files to Amazon S3. Configure an S3 PUT event to invoke an AWS Lambda function to convert the files.
- B. Save the PDF files to DynamoDB. Use DynamoDB Streams to invoke a Lambda function to convert the files.
- C. Save the PDF files to an EBS store. Use an EC2 instance to convert the files.
- D. Save the PDF files to Amazon EFS. Use AWS Batch to convert the files.

**Answer: A**

**Explanation:** S3 event notifications triggering Lambda is a serverless, scalable solution for on-demand file processing. Lambda can handle PDF to image conversion without managing servers.

---

## Question 7: EMR Cluster Optimization

**Scenario:** A solutions architect needs to optimize a large data analytics job that runs on an Amazon EMR cluster. The job takes 13 hours to finish. The cluster has multiple core nodes and worker nodes. After reviewing EMR logs, the solutions architect discovers that several nodes are idle for more than 5 hours.

**Options:**
- A. Increase the number of core nodes to ensure there is enough processing power.
- B. Use the EMR managed scaling feature to automatically resize the cluster based on workload.
- C. Use spot instances for worker nodes.
- D. Configure task nodes for the EMR cluster.

**Answer: B**

**Explanation:** EMR managed scaling automatically adjusts the number of instances based on workload, reducing idle time and optimizing costs by scaling down when nodes are underutilized.

---

## Question 8: DynamoDB Performance Under Load

**Scenario:** An e-commerce company has an application that uses Amazon DynamoDB tables configured with provisioned capacity. During peak traffic, some requests are throttled.

**Options:**
- A. Enable DynamoDB auto scaling.
- B. Use DynamoDB Global Tables for replication.
- C. Switch to on-demand capacity mode.
- D. Increase the number of partitions.

**Answer: A**

**Explanation:** DynamoDB auto scaling automatically adjusts read and write capacity based on actual usage, preventing throttling while optimizing costs during variable workloads.

---

## Question 9: RDS High Availability

**Scenario:** A company is deploying a critical application by using Amazon RDS for MySQL. The application must be highly available.

**Options:**
- A. Create Read Replicas across multiple AZs.
- B. Enable Multi-AZ deployment.
- C. Enable automatic backups with retention period.
- D. Enable RDS Encryption at rest.

**Answer: B**

**Explanation:** Multi-AZ deployment provides automatic failover to a standby in a different AZ, ensuring high availability for critical applications.

---

## Question 10: EC2 SSH Access Security

**Scenario:** A company's developers want a secure way to gain SSH access on the company's EC2 instances. The EC2 instances are hosted in a VPC private subnet and access the internet through a NAT gateway.

**Options:**
- A. Create an SSH bastion host in the public subnet.
- B. Use AWS Systems Manager Session Manager.
- C. Configure SSH access through VPN.
- D. Use EC2 Instance Connect.

**Answer: B**

**Explanation:** AWS Systems Manager Session Manager provides secure, audited access to EC2 instances without needing SSH ports open, bastion hosts, or SSH keys.

---

## Question 11: Network Load Balancer with TLS

**Scenario:** A company has a three-tier environment on AWS that ingests sensor data from its users' devices. The traffic spikes cause performance issues.

**Options:**
- A. Configure a TLS listener and add the server certificate on the NLB.
- B. Configure AWS Shield Advanced and enable AWS Shield Automatic Application Layer DDoS Mitigation.
- C. Use an Auto Scaling group with target tracking scaling based on the CPU utilization of the instances.
- D. Implement Amazon CloudFront to cache static content and reduce load.

**Answer: A**

**Explanation:** TLS listeners on NLB enable encrypted communication. For performance issues during traffic spikes, configure appropriate scaling policies.

---

## Question 12: S3 Website Hosting with HTTPS

**Scenario:** A Solutions Architect is hosting a website in an Amazon S3 bucket named `tutorialsdojo`. The users load the website using the URL `http://tutorialsdojo.s3-website-us-east-1.amazonaws.com`. A new requirement has been added.

**Options:**
- A. Enable S3 static website hosting with HTTP only.
- B. Use CloudFront with an ACM certificate for HTTPS.
- C. Configure S3 Transfer Acceleration.
- D. Use Amazon API Gateway as a proxy.

**Answer: B**

**Explanation:** CloudFront with AWS Certificate Manager (ACM) provides HTTPS support for S3 static websites, improving security and performance through CDN.

---

## Question 13: Auto Scaling for Predictable Traffic

**Scenario:** A tech company has a CRM application hosted on an Auto Scaling group of On-Demand EC2 instances. The application is extensively used during office hours from 9 AM to 5 PM. Users complain that performance is slow at the start of the day but works normally after a couple of hours.

**Options:**
- A. Configure a Predictive scaling policy for the Auto Scaling group.
- B. Configure a Dynamic scaling policy based on Memory utilization.
- C. Configure a Dynamic scaling policy for the Auto Scaling group to launch new instances based on CPU utilization.
- D. Configure a Scheduled scaling policy for the Auto Scaling group to launch new instances before the start of the day.

**Answer: D**

**Explanation:** Scheduled scaling allows you to scale based on predictable traffic patterns. Launching instances before peak hours ensures resources are available when users start.

---

## Question 14: ElastiCache Configuration

**Scenario:** A company plans to use Amazon ElastiCache for its multi-tier web application. A solutions architect needs to configure the cache cluster.

**Options:**
- A. Deploy ElastiCache in cluster mode disabled with read replicas.
- B. Deploy ElastiCache in cluster mode enabled.
- C. Deploy ElastiCache with encryption in transit.
- D. Deploy ElastiCache with both encryption at rest and in transit.

**Answer: D**

**Explanation:** For production workloads, both encryption at rest and in transit should be enabled to ensure comprehensive security for cached data.

---

## Question 15: S3 Object Retrieval

**Scenario:** A company needs to retrieve multiple byte ranges of an object in parallel to increase download throughput.

**Options:**
- A. Use S3 Select to retrieve specific data.
- B. Use byte-range GET requests.
- C. Use S3 Multipart Upload.
- D. Enable S3 Transfer Acceleration.

**Answer: B**

**Explanation:** Byte-range GET requests allow fetching specific portions of an S3 object in parallel, increasing throughput for large file downloads.

---

## Question 16: EC2 Cost Optimization

**Scenario:** A company is concerned about over-provisioning of EC2 resources that causes higher operating costs.

**Options:**
- A. Purchase Reserved Instances for baseline capacity.
- B. Use Spot Instances for all workloads.
- C. Enable Auto Scaling with Memory-based metrics.
- D. Use smaller instance types.

**Answer: A**

**Explanation:** Reserved Instances provide significant discounts for consistent baseline capacity, addressing over-provisioning while maintaining availability.

---

## Question 17: S3 Versioning and Encryption

**Scenario:** A company stores sensitive customer data in S3. The data must be encrypted at rest and have version history.

**Options:**
- A. Enable S3 Versioning and use SSE-KMS encryption.
- B. Enable S3 Cross-Region Replication with encryption.
- C. Enable S3 Intelligent-Tiering.
- D. Use S3 Glacier for archival.

**Answer: A**

**Explanation:** S3 Versioning maintains object history, and SSE-KMS provides encryption at rest with customer-managed keys for sensitive data.

---

## Question 18: VPC Architecture

**Scenario:** A solutions architect needs to design a VPC with resources in both public and private subnets. Database servers should not be directly accessible from the internet.

**Options:**
- A. Place databases in the public subnet with security groups restricting access.
- B. Place databases in the private subnet with NAT gateway for outbound access.
- C. Place databases in the private subnet with VPC endpoints for AWS services.
- D. Place databases in a completely isolated VPC with VPN connectivity.

**Answer: C**

**Explanation:** Private subnet databases with VPC endpoints provide secure, scalable access to AWS services without internet exposure.

---

## Question 19: API Gateway Integration

**Scenario:** A company has a serverless application using API Gateway and Lambda. The company needs to process orders asynchronously.

**Options:**
- A. Configure API Gateway to invoke Lambda synchronously.
- B. Configure API Gateway to put messages to an SQS queue, which triggers Lambda.
- C. Use API Gateway WebSocket APIs.
- D. Configure API Gateway with Lambda invocations through SNS.

**Answer: B**

**Explanation:** SQS provides asynchronous message queuing, allowing Lambda to process orders at its own pace, handling bursts without overwhelming the system.

---

## Question 20: CloudWatch Monitoring

**Scenario:** A company needs to monitor application logs and create alarms based on specific patterns.

**Options:**
- A. Use CloudWatch Logs with metric filters.
- B. Use CloudWatch Contributor Insights.
- C. Use CloudWatch Embedded Metrics Format.
- D. Use CloudWatch Application Insights.

**Answer: A**

**Explanation:** CloudWatch Logs metric filters allow you to extract custom metrics from log data and create alarms based on specific patterns.

---

## Question 21: Lambda Cold Start Optimization

**Scenario:** A company experiences slow response times due to Lambda cold starts during spike traffic.

**Options:**
- A. Increase Lambda memory size.
- B. Use Lambda Provisioned Concurrency.
- C. Reduce Lambda timeout.
- D. Use Lambda Layers.

**Answer: B**

**Explanation:** Provisioned Concurrency keeps Lambda functions initialized and ready, eliminating cold starts for consistent low-latency responses.

---

## Question 22: Aurora Global Database

**Scenario:** A company needs to deploy a database across multiple AWS regions for disaster recovery with RPO of approximately 1 second.

**Options:**
- A. Configure RDS Read Replicas in another region.
- B. Use Aurora Global Database.
- C. Configure manual cross-region snapshots.
- D. Use DynamoDB Global Tables.

**Answer: B**

**Explanation:** Aurora Global Database provides automatic replication with approximately 1-second RPO across regions for disaster recovery scenarios.

---

## Question 23: ALB vs NLB Selection

**Scenario:** A company needs to distribute traffic to applications running on both TCP and UDP protocols.

**Options:**
- A. Use Application Load Balancer (ALB).
- B. Use Network Load Balancer (NLB).
- C. Use Classic Load Balancer (CLB).
- D. Use Gateway Load Balancer.

**Answer: B**

**Explanation:** Network Load Balancer (NLB) supports TCP, UDP, and TLS traffic, making it suitable for applications requiring both TCP and UDP protocols.

---

## Question 24: S3 Lifecycle Policies

**Scenario:** A company needs to automatically move S3 objects to cheaper storage classes based on access patterns.

**Options:**
- A. Configure S3 Lifecycle policies with transition rules.
- B. Use S3 Intelligent-Tiering.
- C. Use S3 Storage Lens.
- D. Configure S3 Replication rules.

**Answer: A**

**Explanation:** S3 Lifecycle policies with transition rules automatically move objects between storage classes based on defined criteria like age or access patterns.

---

## Question 25: VPC Endpoints

**Scenario:** An EC2 instance in a private subnet needs to access S3 without going through the internet.

**Options:**
- A. Configure a NAT gateway.
- B. Use a VPC endpoint for S3.
- C. Set up a VPN connection.
- D. Use AWS Direct Connect.

**Answer: B**

**Explanation:** VPC endpoints enable private connectivity to S3 without internet traversal, improving security and reducing latency.

---

## Question 26: RDS Backup Strategy

**Scenario:** A company needs to configure database backups with point-in-time recovery capability.

**Options:**
- A. Enable automated backups with retention period.
- B. Create manual snapshots daily.
- C. Enable RDS encryption.
- D. Configure Multi-AZ deployment.

**Answer: A**

**Explanation:** Automated backups with point-in-time recovery enabled allow restoration to any second within the retention period (1-35 days).

---

## Question 27: CloudFront Cache Behavior

**Scenario:** A company wants to reduce origin load by caching static assets longer at CloudFront edge locations.

**Options:**
- A. Set a longer default TTL.
- B. Configure cache-control headers from the origin.
- C. Enable CloudFront Origin Shield.
- D. Use CloudFront Functions.

**Answer: B**

**Explanation:** Cache-control headers from the origin allow precise control over caching behavior, enabling longer TTLs for static assets without affecting dynamic content.

---

## Question 28: DynamoDB Global Tables

**Scenario:** A company needs to distribute a database across multiple regions for low-latency reads and writes globally.

**Options:**
- A. Configure DynamoDB streams with Lambda.
- B. Use DynamoDB Global Tables.
- C. Use DynamoDB Accelerator (DAX).
- D. Configure cross-region read replicas.

**Answer: B**

**Explanation:** DynamoDB Global Tables provide fully managed, multi-region, multi-active replication for global applications with automatic failover.

---

## Question 29: Security Group Configuration

**Scenario:** A company needs to configure security groups for a three-tier application (web, application, database).

**Options:**
- A. Allow all traffic from 0.0.0.0/0 to all tiers.
- B. Web tier allows HTTP/HTTPS from internet, app tier from web tier only, database from app tier only.
- C. Allow database tier to initiate connections to app tier.
- D. Use the same security group for all tiers.

**Answer: B**

**Explanation:** Following the principle of least privilege, each tier should only accept traffic from the tier directly above it, creating a secure layered architecture.

---

## Question 30: AWS Organizations SCP

**Scenario:** A company uses AWS Organizations and needs to prevent member accounts from creating certain resources.

**Options:**
- A. Use Service Control Policies (SCPs).
- B. Use IAM policies in member accounts.
- C. Use AWS Config rules.
- D. Use AWS GuardDuty.

**Answer: A**

**Explanation:** SCPs provide central control over the maximum available permissions for all accounts in an AWS Organization, preventing certain actions across member accounts.

---

## Question 31: EFS vs EBS vs S3

**Scenario:** A company needs shared storage accessible from multiple EC2 instances across multiple AZs.

**Options:**
- A. Use Amazon EBS with Multi-Attach.
- B. Use Amazon EFS with Multi-AZ deployment.
- C. Use Amazon S3 with Transfer Acceleration.
- D. Use FSx for Windows File Server.

**Answer: B**

**Explanation:** Amazon EFS provides scalable, POSIX-compliant file storage accessible from multiple instances across AZs, ideal for shared file storage requirements.

---

## Question 32: Lambda Concurrency

**Scenario:** A company has a Lambda function processing orders that must not exceed a specific rate to avoid overwhelming downstream systems.

**Options:**
- A. Configure reserved concurrency.
- B. Increase Lambda timeout.
- C. Use Lambda destinations.
- D. Configure Lambda provisioned concurrency.

**Answer: A**

**Explanation:** Reserved concurrency limits the maximum concurrent executions for a function, preventing it from overwhelming downstream systems.

---

## Question 33: S3 Replication Without Overwriting

**Scenario:** A company needs to replicate S3 objects to another region while preserving all versions.

**Options:**
- A. Configure S3 Cross-Region Replication (CRR) with existing objects.
- B. Use S3 Batch Replication.
- C. Use AWS DataSync.
- D. Configure S3 Transfer Acceleration.

**Answer: B**

**Explanation:** S3 Batch Replication can replicate existing objects and object versions that existed before replication was configured.

---

## Question 34: API Gateway Caching

**Scenario:** A company wants to reduce Lambda costs by caching frequent API responses.

**Options:**
- A. Enable API Gateway default endpoint.
- B. Enable API Gateway caching.
- C. Use CloudFront caching in front of API Gateway.
- D. Configure Lambda response caching.

**Answer: B**

**Explanation:** API Gateway caching stores API responses, reducing Lambda invocations and improving response times for repeated requests.

---

## Question 35: VPC Flow Logs Analysis

**Scenario:** A company needs to analyze VPC traffic patterns and identify security threats.

**Options:**
- A. Enable VPC Flow Logs to CloudWatch Logs.
- B. Enable VPC Flow Logs to S3.
- C. Use AWS Network Firewall.
- D. Use AWS Direct Connect.

**Answer: A**

**Explanation:** VPC Flow Logs to CloudWatch Logs enable real-time analysis of traffic patterns and security threat identification using CloudWatch Logs Insights.

---

## Question 36: ECS Service Auto Scaling

**Scenario:** An ECS service experiences variable traffic and needs automatic capacity adjustment.

**Options:**
- A. Use target tracking scaling based on memory utilization.
- B. Use step scaling based on request count.
- C. Use scheduled scaling.
- D. Use all of the above.

**Answer: D**

**Explanation:** Combining target tracking, step scaling, and scheduled scaling provides comprehensive auto scaling for different workload patterns.

---

## Question 37: IAM Policy Evaluation

**Scenario:** A user has multiple IAM policies attached. One allows S3 access, another explicitly denies S3 access. What happens?

**Options:**
- A. The allow policy takes precedence.
- B. The deny policy takes precedence.
- C. Both policies are combined.
- D. Access is denied by default.

**Answer: B**

**Explanation:** In IAM, an explicit deny always overrides an allow. This is the fundamental principle of IAM policy evaluation.

---

## Question 38: Route 53 Routing

**Scenario:** A company needs to route traffic to the nearest healthy endpoint with the lowest latency.

**Options:**
- A. Use Route 53 latency-based routing.
- B. Use Route 53 geolocation routing.
- C. Use Route 53 geoproximity routing.
- D. Use Route 53 simple routing.

**Answer: A**

**Explanation:** Latency-based routing evaluates which AWS region provides the lowest latency to the user, directing traffic accordingly.

---

## Question 39: Glacier Vault Lock

**Scenario:** A company needs to enforce retention policies that cannot be changed or deleted.

**Options:**
- A. Use S3 Object Lock with governance mode.
- B. Use S3 Glacier Vault Lock.
- C. Use S3 Lifecycle policies.
- D. Use bucket policies.

**Answer: B**

**Explanation:** S3 Glacier Vault Lock allows you to lock the vault access policy, ensuring compliance requirements cannot be modified after locking.

---

## Question 40: EC2 Instance Recovery

**Scenario:** An EC2 instance in an Auto Scaling group fails. The company needs automatic recovery.

**Options:**
- A. Use CloudWatch alarms with EC2 auto recovery actions.
- B. Configure Health Checks on the Auto Scaling group.
- C. Use AWS Systems Manager.
- D. Enable detailed monitoring.

**Answer: A**

**Explanation:** CloudWatch alarms with EC2 auto recovery actions automatically recover impaired instances without manual intervention.

---

## Quick Reference: Key AWS Services

### Compute
- **EC2**: Virtual servers
- **Lambda**: Serverless functions
- **ECS/EKS**: Container orchestration
- **Fargate**: Serverless containers
- **Lightsail**: Simple VPS

### Storage
- **S3**: Object storage
- **EBS**: Block storage
- **EFS**: File storage
- **FSx**: Managed file systems
- **Storage Gateway**: Hybrid storage

### Database
- **RDS**: Relational databases (MySQL, PostgreSQL, etc.)
- **Aurora**: MySQL/PostgreSQL compatible
- **DynamoDB**: NoSQL
- **ElastiCache**: In-memory caching
- **Neptune**: Graph database

### Networking
- **VPC**: Virtual network
- **Route 53**: DNS service
- **CloudFront**: CDN
- **ELB**: Load balancing
- **API Gateway**: API management

### Security
- **IAM**: Identity management
- **Cognito**: User authentication
- **KMS**: Key management
- **WAF/Shield**: DDoS protection
- **Security Hub**: Security center

---

## Exam Tips

### Time Management
- Spend approximately 2 minutes per question
- Flag difficult questions and return later
- Don't spend too long on any single question

### Question Analysis
1. Read the scenario carefully
2. Identify key requirements (availability, scalability, cost, security)
3. Eliminate obviously wrong answers
4. Look for "MOST" or "LEAST" modifiers
5. Consider AWS best practices

### Common Traps
- Overlooking explicit deny statements
- Selecting "always" or "never" options
- Choosing manual solutions over managed services
- Ignoring cost implications
- Missing security requirements

### Services Comparison

| Need | Best Service |
|------|-------------|
| Object storage | S3 |
| Block storage | EBS |
| File storage | EFS/FSx |
| NoSQL database | DynamoDB |
| Relational database | RDS/Aurora |
| Caching | ElastiCache |
| Serverless compute | Lambda |
| Container orchestration | EKS/ECS |
| Load balancing | ALB/NLB |
| CDN | CloudFront |
| DNS | Route 53 |
| Message queue | SQS |
| Event processing | EventBridge |

---

## Answer Key

| # | Answer | Domain |
|----|--------|--------|
| 1 | A | High-Performing |
| 2 | B | High-Performing |
| 3 | A | Secure |
| 4 | B | High-Performing |
| 5 | D | Resilient |
| 6 | A | High-Performing |
| 7 | B | Resilient |
| 8 | A | High-Performing |
| 9 | B | Resilient |
| 10 | B | Secure |
| 11 | A | High-Performing |
| 12 | B | Secure |
| 13 | D | High-Performing |
| 14 | D | Secure |
| 15 | B | High-Performing |
| 16 | A | Cost-Optimized |
| 17 | A | Secure |
| 18 | C | Secure |
| 19 | B | Resilient |
| 20 | A | Resilient |
| 21 | B | High-Performing |
| 22 | B | Resilient |
| 23 | B | High-Performing |
| 24 | A | Cost-Optimized |
| 25 | B | Secure |
| 26 | A | Resilient |
| 27 | B | High-Performing |
| 28 | B | Resilient |
| 29 | B | Secure |
| 30 | A | Secure |
| 31 | B | High-Performing |
| 32 | A | High-Performing |
| 33 | B | Resilient |
| 34 | B | Cost-Optimized |
| 35 | A | Secure |
| 36 | D | High-Performing |
| 37 | B | Secure |
| 38 | A | Resilient |
| 39 | B | Secure |
| 40 | A | Resilient |

---

**Good luck with your AWS Solutions Architect Associate exam!**
