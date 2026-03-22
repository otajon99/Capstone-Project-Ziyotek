# AWS Certified Solutions Architect Associate (SAA-C03) Exam Questions & Answers 2026

## Exam Overview

| Item | Details |
|------|---------|
| Exam Code | SAA-C03 |
| Duration | 130 minutes |
| Questions | 65 (50 scored, 15 unscored) |
| Passing Score | 720/1000 (~72%) |
| Cost | $150 USD |
| Format | Multiple choice, scenario-based |
| Validity | 3 years |

---

## Exam Domains

| Domain | Weight |
|--------|--------|
| Design Secure Architectures | 30% |
| Design Resilient Architectures | 26% |
| Design High-Performing Architectures | 24% |
| Design Cost-Optimized Architectures | 20% |

---

## Topic 1: Global Data Aggregation

**Scenario:** A company collects data for temperature, humidity, and atmospheric pressure in cities across multiple continents. The average volume of data that the company collects from each site daily is 500 GB. Each site has a high-speed Internet connection. The company wants to aggregate the data from all these global sites as quickly as possible in a single Amazon S3 bucket. The solution must minimize operational complexity.

**Options:**
- A. Turn on S3 Transfer Acceleration on the destination S3 bucket. Use multipart uploads to directly upload site data to the destination S3 bucket.
- B. Upload the data from each site to an S3 bucket in the closest Region. Use S3 Cross-Region Replication to copy objects to the destination S3 bucket.
- C. Schedule AWS Snowball Edge Storage Optimized device jobs daily to transfer data from each site.
- D. Upload the data from each site to an Amazon EC2 instance in the closest Region. Store the data in an Amazon EBS volume.

**Answer: A**

**Explanation:** S3 Transfer Acceleration utilizes Amazon CloudFront's globally distributed edge locations to accelerate uploads. For large volumes of data from multiple global sites with high-speed internet, this provides the fastest path to aggregate data in S3.

---

## Topic 2: Log Analysis with On-Demand Queries

**Scenario:** A company needs the ability to analyze the log files of its proprietary application. The logs are stored in JSON format in an Amazon S3 bucket. Queries will be simple and will run on-demand.

**Options:**
- A. Use Amazon Redshift to load all the content and run SQL queries.
- B. Use Amazon CloudWatch Logs to store the logs.
- C. Use Amazon Athena directly with Amazon S3 to run the queries.
- D. Use AWS Glue to catalog the logs and use EMR for SQL queries.

**Answer: C**

**Explanation:** Amazon Athena is an interactive query service that makes it easy to analyze data directly in Amazon S3 using standard SQL with minimal operational overhead.

---

## Topic 3: S3 Bucket Access Restriction

**Scenario:** A company uses AWS Organizations to manage multiple AWS accounts. The company wants to limit access to an S3 bucket to only users of accounts within the organization.

**Options:**
- A. Add the `aws:PrincipalOrgID` global condition key to the S3 bucket policy.
- B. Create an OU for each department and use `aws:PrincipalOrgPaths`.
- C. Use AWS CloudTrail to monitor organization events.
- D. Tag each user and use `aws:PrincipalTag`.

**Answer: A**

**Explanation:** The `aws:PrincipalOrgID` condition key restricts access to only principals from accounts in the specified AWS Organization.

---

## Topic 4: Private Network Connectivity to S3

**Scenario:** An application runs on an Amazon EC2 instance in a VPC. The EC2 instance needs to access the S3 bucket without connectivity to the internet.

**Options:**
- A. Create a gateway VPC endpoint to the S3 bucket.
- B. Stream the logs to CloudWatch Logs and export to S3.
- C. Create an instance profile on EC2.
- D. Create an Amazon API Gateway API with private link.

**Answer: A**

**Explanation:** A VPC endpoint for S3 allows private connectivity to Amazon S3 without using an internet gateway or NAT device.

---

## Topic 5: Multi-AZ Document Storage

**Scenario:** A company duplicated their architecture across AZs but users can only see documents from one server at a time.

**Options:**
- A. Copy the data so both EBS volumes contain all documents
- B. Configure the ALB to direct users to the server with documents
- C. Copy the data from both EBS volumes to Amazon EFS. Modify the application to save new documents to Amazon EFS
- D. Configure the ALB to send requests to both servers

**Answer: C**

**Explanation:** Amazon EFS provides scalable, POSIX-compliant file storage accessible from multiple instances across AZs, allowing both EC2 instances to access the same file system.

---

## Topic 6: On-Premises Large File Migration

**Scenario:** A company uses NFS to store large video files (up to 500GB each, 70TB total). The company wants to migrate to S3 as quickly as possible using the least network bandwidth.

**Options:**
- A. Use AWS CLI to copy all files to S3.
- B. Create an AWS Snowball Edge job to transfer data.
- C. Deploy an S3 File Gateway on premises.
- D. Set up AWS Direct Connect and use S3 File Gateway.

**Answer: B**

**Explanation:** Snowball Edge devices can transfer data at speeds up to 100 Gbps. For 70 TB, this would take less than 2 hours locally, using zero network bandwidth.

---

## Topic 7: Message Queue for Variable Workloads

**Scenario:** A company has an application that ingests incoming messages. Dozens of applications consume these messages. The number of messages varies drastically and sometimes increases suddenly to 100,000 each second.

**Options:**
- A. Persist messages to Kinesis Data Analytics.
- B. Deploy the ingestion application on EC2 instances in an Auto Scaling group.
- C. Write messages to Kinesis Data Streams with a single shard.
- D. Publish messages to Amazon SNS with multiple SQS subscriptions.

**Answer: D**

**Explanation:** SNS with SQS subscriptions provides a pub/sub messaging pattern that decouples producers from consumers.

---

## Topic 8: Distributed Job Processing

**Scenario:** A company is migrating a distributed application with a primary server that coordinates jobs across multiple compute nodes. The company wants to maximize resiliency and scalability.

**Options:**
- A. Configure SQS queue with scheduled scaling.
- B. Configure SQS queue with Auto Scaling based on queue size.
- C. Implement primary server and compute nodes with CloudTrail as job destination.
- D. Implement primary server and compute nodes with EventBridge.

**Answer: B**

**Explanation:** SQS queues provide a decoupled architecture. Auto Scaling based on queue depth allows the system to automatically scale based on actual workload demand.

---

## Topic 9: SMB File Server Lifecycle Management

**Scenario:** A company runs an SMB file server. Files are accessed frequently for the first few days, then rarely accessed after 7 days. Total data is close to capacity.

**Options:**
- A. Use AWS DataSync to copy data older than 7 days to AWS.
- B. Create an Amazon S3 File Gateway. Create an S3 Lifecycle policy to transition data to S3 Glacier Deep Archive after 7 days.
- C. Create an Amazon FSx for Windows File Server.
- D. Install a utility on each user's computer to access Amazon S3.

**Answer: B**

**Explanation:** S3 File Gateway provides a hybrid cloud storage solution. S3 Lifecycle policies can automatically transition objects to Glacier Deep Archive after 7 days.

---

## Topic 10: Order Processing Queue

**Scenario:** A company is building an ecommerce web application. The company wants to ensure that orders are processed in the order that they are received.

**Options:**
- A. Use API Gateway to publish to SNS topic, subscribe Lambda to process.
- B. Use API Gateway to send to SQS FIFO queue, configure Lambda for processing.
- C. Use API Gateway authorizer to block requests while processing.
- D. Use API Gateway to send to SQS standard queue, configure Lambda.

**Answer: B**

**Explanation:** SQS FIFO queues guarantee message ordering and exactly-once processing, ensuring orders are processed in exact order.

---

## Topic 11: Database Credential Management

**Scenario:** An application runs on EC2 instances and uses an Aurora database. EC2 instances connect using credentials stored locally in a file. The company wants to minimize operational overhead.

**Options:**
- A. Use AWS Secrets Manager with IAM role and automatic rotation.
- B. Store credentials in S3 with server-side encryption.
- C. Use AWS Systems Manager Parameter Store.
- D. Create a new database user for each application instance.

**Answer: A**

**Explanation:** AWS Secrets Manager enables you to rotate, manage, and retrieve secrets throughout their lifecycle with automatic rotation.

---

## Topic 12: Performance for Static and Dynamic Content

**Scenario:** A global company hosts its web application on EC2 instances behind an ALB. The application has static data in S3 and dynamic data. The company wants to improve performance and reduce latency.

**Options:**
- A. Create a CloudFront distribution with S3 bucket and ALB as origins. Configure Route 53 to route to CloudFront.
- B. Create CloudFront distribution with S3 as origin. Configure Route 53 separately for ALB.
- C. Use S3 Transfer Acceleration.
- D. Create CloudFront distribution with ALB as only origin.

**Answer: A**

**Explanation:** CloudFront allows multiple origins for both static (S3) and dynamic (ALB) content, caching at edge locations to reduce latency.

---

## Topic 13: RDS Credential Rotation

**Scenario:** A company performs monthly maintenance and needs to rotate RDS for MySQL credentials across multiple AWS Regions.

**Options:**
- A. Store credentials in Secrets Manager with multi-Region replication and automatic rotation.
- B. Store credentials in Systems Manager Parameter Store and create update scripts.
- C. Create a Lambda function that rotates credentials.
- D. Use IAM database authentication.

**Answer: A**

**Explanation:** Secrets Manager allows you to store, manage, and rotate secrets across multiple AWS Regions with multi-Region replication.

---

## Topic 14: Auto Scaling Database for Read Workloads

**Scenario:** An ecommerce application uses MySQL on EC2. Database performance degrades as load increases. The application handles more read requests than writes.

**Options:**
- A. Use RDS for MySQL with Multi-AZ and read replicas.
- B. Use DynamoDB with auto scaling.
- C. Use Aurora with Multi-AZ and Aurora Auto Scaling with Aurora Replicas.
- D. Use ElastiCache for Redis.

**Answer: C**

**Explanation:** Amazon Aurora with Multi-AZ deployment and Aurora Auto Scaling provides automatic scaling of Aurora Replicas based on workload.

---

## Topic 15: VPC Traffic Inspection

**Scenario:** A company migrated to AWS and wants to protect VPC traffic. The company had an inspection server on-premises for traffic flow inspection and filtering.

**Options:**
- A. Deploy a NAT gateway and configure filtering.
- B. Deploy AWS WAF web ACL.
- C. Use AWS Network Firewall for traffic inspection and filtering.
- D. Configure VPC Flow Logs with Lambda analysis.

**Answer: C**

**Explanation:** AWS Network Firewall is a managed firewall service that provides filtering for both inbound and outbound network traffic.

---

## Topic 16: Data Lake Reporting Solution

**Scenario:** A company hosts a data lake with data in S3 and RDS for PostgreSQL. The company needs reporting with data visualization and different access levels.

**Options:**
- A. Create QuickSight analyses for each data source.
- B. Create a QuickSight analysis connecting all data sources, publish dashboards with appropriate sharing.
- C. Use Athena to query and QuickSight for reporting.
- D. Use Amazon Redshift to consolidate data.

**Answer: B**

**Explanation:** Amazon QuickSight connects all data sources, creates datasets, and provides fine-grained access control for dashboards.

---

## Topic 17: EC2 Access to S3 Bucket

**Scenario:** An application runs on two EC2 instances and uses an S3 bucket for document storage.

**Options:**
- A. Create an IAM role that grants access to S3. Attach the role to EC2 instances.
- B. Create an IAM user with credentials stored on EC2.
- C. Configure S3 bucket policy with EC2 IP addresses.
- D. Use S3 pre-signed URLs.

**Answer: A**

**Explanation:** An IAM role attached to EC2 instances allows them to make API calls to S3 without storing long-term credentials.

---

## Topic 18: Image Processing Microservice

**Scenario:** A microservice converts large images to compressed images. The solution should use durable, stateless components.

**Options (Choose two):**
- A. Create an SQS queue. Configure S3 to send notifications to the queue.
- B. Configure Lambda to use SQS queue as invocation source.
- C. Configure Lambda to be triggered by S3 events directly.
- D. Use EventBridge to trigger Lambda.

**Answer: A, B**

**Explanation:** SQS queue provides durable buffering. Lambda reading from SQS processes messages in a stateless manner with automatic retry.

---

## Topic 19: Traffic Inspection with Appliance

**Scenario:** A three-tier web application needs to integrate with a third-party firewall appliance in an inspection VPC.

**Options:**
- A. Configure ALB to route through the firewall appliance.
- B. Deploy a NAT gateway in front of web servers.
- C. Deploy a Gateway Load Balancer in the inspection VPC. Create a Gateway Load Balancer endpoint.
- D. Use AWS PrivateLink.

**Answer: C**

**Explanation:** Gateway Load Balancer operates at layer 3 and allows inline inspection of traffic from multiple VPCs through centralized virtual appliances.

---

## Topic 20: Fast Snapshot Restore

**Scenario:** A company wants to clone large amounts of production data to a test environment. Software requires consistently high I/O performance.

**Options:**
- A. Take EBS snapshots and restore to new volumes in test environment.
- B. Take EBS snapshots with EBS fast snapshot restore enabled. Restore to new volumes.
- C. Create a copy of EBS volumes.
- D. Use AWS DataSync.

**Answer: B**

**Explanation:** EBS fast snapshot restore (FSR) creates volumes that are fully initialized at creation, instantly delivering all provisioned performance.

---

## Topic 21: One-Deal-A-Day Website

**Scenario:** An ecommerce company wants to launch a one-deal-a-day website that can handle millions of requests per hour with millisecond latency.

**Options:**
- A. Use EC2 Auto Scaling group with load balancer.
- B. Use Elastic Beanstalk with auto scaling.
- C. Use S3 for static content, CloudFront for distribution, API Gateway + Lambda for backend, DynamoDB for data.
- D. Use Amazon Lightsail.

**Answer: C**

**Explanation:** This serverless architecture leverages fully managed services that automatically scale to meet demand with minimal operational overhead.

---

## Topic 22: S3 Storage for Unpredictable Access

**Scenario:** Media files must be resilient to AZ loss. Some files are accessed frequently, others rarely in unpredictable patterns.

**Options:**
- A. Use S3 Standard-IA.
- B. Use S3 Intelligent-Tiering.
- C. Use S3 Standard for all files.
- D. Use S3 Glacier for all files.

**Answer: B**

**Explanation:** S3 Intelligent-Tiering automatically moves data to the most cost-effective storage tier based on access patterns.

---

## Topic 23: S3 Lifecycle for Indefinite Storage

**Scenario:** A company stores backup files in S3 Standard. Files are accessed frequently for 1 month, then not accessed. Must keep files indefinitely.

**Options:**
- A. Transition to S3 Standard-IA after 1 month.
- B. Transition to S3 Glacier Deep Archive after 1 month.
- C. Move to Amazon Glacier after 1 month.
- D. Enable S3 Intelligent-Tiering.

**Answer: B**

**Explanation:** S3 Glacier Deep Archive is the lowest-cost S3 storage option, ideal for data that must be kept indefinitely but is rarely accessed.

---

## Topic 24: EC2 Cost Analysis

**Scenario:** A company notices increased EC2 costs and wants to analyze costs by instance type over time.

**Options:**
- A. Use AWS Cost Explorer with granular filtering by instance type.
- B. Download billing reports and analyze in Excel.
- C. Use AWS Budgets for alerts.
- D. Use AWS Trusted Advisor.

**Answer: A**

**Explanation:** Cost Explorer's granular filtering allows in-depth analysis of EC2 costs based on instance types over time.

---

## Topic 25: Lambda Scalability Design

**Scenario:** An application uses Lambda through API Gateway to store data in Aurora PostgreSQL. The company needs to improve scalability.

**Options:**
- A. Increase Lambda timeout and memory.
- B. Use SQS to decouple Lambda from database.
- C. Set up two Lambda functions with SQS queue between them.
- D. Use AWS Step Functions.

**Answer: C**

**Explanation:** Dividing functionality into two Lambda functions with SQS queue allows independent scaling and optimization of each function.

---

## Topic 26: S3 Configuration Change Monitoring

**Scenario:** A company needs to ensure S3 buckets don't have unauthorized configuration changes.

**Options:**
- A. Turn on AWS Config with appropriate rules.
- B. Use CloudWatch Events to monitor S3 configurations.
- C. Enable S3 server access logging.
- D. Use AWS Trusted Advisor.

**Answer: A**

**Explanation:** AWS Config monitors and records configuration changes to AWS resources and can detect unauthorized changes.

---

## Topic 27: Dashboard Access for Non-AWS Users

**Scenario:** A product manager needs access to CloudWatch dashboards but doesn't have an AWS account.

**Options:**
- A. Share the dashboard from CloudWatch console with email address.
- B. Create an IAM user and provide credentials.
- C. Enable cross-account access.
- D. Export dashboard data to S3.

**Answer: A**

**Explanation:** CloudWatch dashboards can be shared with people who don't have AWS accounts through email-based sign-up.

---

## Topic 28: SSO with On-Premises Active Directory

**Scenario:** A company needs SSO across multiple AWS accounts using on-premises Microsoft Active Directory.

**Options:**
- A. Enable AWS SSO and create trust with AWS Directory Service for Microsoft AD.
- B. Create IAM users in each account.
- C. Use SAML 2.0 federation.
- D. Use Amazon Cognito.

**Answer: A**

**Explanation:** AWS SSO integrates with AWS Directory Service for Microsoft AD, allowing use of existing AD credentials.

---

## Topic 29: VoIP Service with Global Routing

**Scenario:** A VoIP service uses UDP connections on EC2 instances across multiple Regions. The company needs lowest latency routing and automated failover.

**Options:**
- A. Deploy NLB with target group, use as Global Accelerator endpoint in each Region.
- B. Use Route 53 with latency-based routing.
- C. Deploy ALB in each Region.
- D. Use CloudFront.

**Answer: A**

**Explanation:** AWS Global Accelerator improves availability and performance by routing traffic through AWS edge locations to the optimal Region.

---

## Topic 30: Monthly Database Testing Cost Optimization

**Scenario:** A development team runs resource-intensive tests on RDS for MySQL once a month for 48 hours. The team wants to reduce costs without reducing compute/memory.

**Options:**
- A. Use RDS reserved instances.
- B. Enable auto scaling.
- C. Create snapshot when tests complete, terminate instance, restore when needed.
- D. Use smaller instance type during testing.

**Answer: C**

**Explanation:** By creating a snapshot and terminating the DB instance, you stop incurring costs when not in use.

---

## Topic 31: Resource Tagging Compliance

**Scenario:** A company wants to ensure all EC2, RDS, and Redshift resources are configured with tags.

**Options:**
- A. Use AWS Config rules to detect untagged resources.
- B. Use AWS Trusted Advisor.
- C. Create Lambda function to check tags daily.
- D. Use Amazon Inspector.

**Answer: A**

**Explanation:** AWS Config can create rules that automatically detect resources that are not properly tagged.

---

## Topic 32: Static Website Hosting

**Scenario:** A development team needs to host a website with HTML, CSS, JavaScript, and images.

**Options:**
- A. Deploy on EC2 instances behind a load balancer.
- B. Create an Amazon S3 bucket and host the website.
- C. Use AWS Elastic Beanstalk.
- D. Use CloudFront with custom origin.

**Answer: B**

**Explanation:** Amazon S3 is the most cost-effective solution for hosting static websites.

---

## Topic 33: Real-Time Transaction Processing

**Scenario:** An online marketplace needs to share millions of financial transactions with internal applications. Transactions need PII removal before storage.

**Options:**
- A. Use SQS to queue transactions for Lambda processing.
- B. Use Kinesis Data Streams, store raw data in S3.
- C. Stream to Kinesis Data Streams, use Lambda to remove PII, store in DynamoDB.
- D. Use AWS Glue to transform and store in Redshift.

**Answer: C**

**Explanation:** Kinesis Data Streams provides real-time ingestion. Lambda can process and remove sensitive data before storing in DynamoDB.

---

## Topic 34: Configuration and API Call Tracking

**Scenario:** For compliance and security, the company must track configuration changes and record API calls.

**Options:**
- A. Use CloudWatch for both.
- B. Use AWS Config for configuration changes and CloudTrail for API calls.
- C. Use CloudTrail for both.
- D. Use AWS X-Ray.

**Answer: B**

**Explanation:** AWS Config tracks configuration changes. CloudTrail records API calls made to AWS resources.

---

## Topic 35: DDoS Protection

**Scenario:** A company is launching a public-facing application on EC2 instances behind an ELB. They need DDoS protection.

**Options:**
- A. Enable AWS WAF with rules.
- B. Enable AWS Shield Advanced on the ELB.
- C. Deploy CloudFront in front of ELB.
- D. Use AWS Network Firewall.

**Answer: B**

**Explanation:** AWS Shield Advanced provides expanded DDoS attack protection for ELB, EC2, CloudFront, Route 53, and Global Accelerator.

---

## Topic 36: Secure Remote Administration

**Scenario:** A company needs secure remote administration for EC2 instances following the Well-Architected Framework.

**Options:**
- A. Deploy a bastion host in a public subnet.
- B. Attach IAM role to instances, use Systems Manager Session Manager.
- C. Use AWS VPN.
- D. Use EC2 Instance Connect.

**Answer: B**

**Explanation:** Systems Manager Session Manager provides secure, auditable node management without needing bastion hosts or SSH keys.

---

## Topic 37: Global Static Website Performance

**Scenario:** A static website on S3 with Route 53 DNS is experiencing increased global demand.

**Options:**
- A. Enable S3 Transfer Acceleration.
- B. Add more EC2 instances.
- C. Add CloudFront distribution in front of S3 bucket, update Route 53.
- D. Use Route 53 with geolocation routing.

**Answer: C**

**Explanation:** CloudFront CDN distributes content globally through edge locations, reducing latency for users worldwide.

---

## Topic 38: RDS Storage Performance

**Scenario:** An RDS for MySQL database with 10 million rows has insert operations taking 10+ seconds due to storage performance.

**Options:**
- A. Change storage type to Provisioned IOPS SSD.
- B. Increase database instance size.
- C. Enable read replicas.
- D. Migrate to Aurora.

**Answer: A**

**Explanation:** Provisioned IOPS SSD provides high-performance storage with reliable throughput and minimal latency for I/O-intensive workloads.

---

## Topic 39: IoT Edge Device Data Ingestion

**Scenario:** Thousands of edge devices generate 1 TB of alerts daily. Company wants highly available solution with 14-day retention and archive older data.

**Options:**
- A. Create Kinesis Data Firehose stream to S3, configure S3 Lifecycle to Glacier after 14 days.
- B. Use SQS queue for Lambda processing.
- C. Store in DynamoDB with TTL.
- D. Use AWS IoT Core.

**Answer: A**

**Explanation:** Kinesis Data Firehose is a fully managed service for streaming data ingestion to S3 with automatic archival to Glacier.

---

## Topic 40: SaaS Data Integration

**Scenario:** An application integrates with multiple SaaS sources. EC2 instances receive and upload data to S3, then notify users. Performance has degraded.

**Options:**
- A. Use AWS DataSync for SaaS to S3 transfer.
- B. Use Amazon AppFlow to transfer data to S3, SNS for notifications.
- C. Use AWS Glue for ETL.
- D. Deploy Lambda to pull from SaaS sources.

**Answer: B**

**Explanation:** Amazon AppFlow is a fully-managed integration service that removes the EC2 middle layer, improving performance.

---

## Topic 41: Avoiding Regional Data Transfer Charges

**Scenario:** EC2 instances download and upload images to S3 through a NAT gateway. Company is concerned about data transfer charges.

**Options:**
- A. Use an internet gateway.
- B. Configure a NAT gateway.
- C. Deploy a gateway VPC endpoint for Amazon S3.
- D. Use AWS Direct Connect.

**Answer: C**

**Explanation:** S3 VPC endpoint routes traffic to S3 through AWS network, avoiding Regional data transfer charges.

---

## Topic 42: On-Premises Backup to S3

**Scenario:** An on-premises application generates time-sensitive data backed up to S3. Internet bandwidth is limited.

**Options:**
- A. Increase internet bandwidth.
- B. Establish AWS Direct Connect connection for backup traffic.
- C. Use AWS Snowball Edge for periodic transfers.
- D. Compress data before uploading.

**Answer: B**

**Explanation:** Direct Connect provides a dedicated network connection from on-premises to AWS, bypassing the public Internet.

---

## Topic 43: S3 Protection from Accidental Deletion

**Scenario:** A company has critical data in S3 and must protect against accidental deletion.

**Options (Choose two):**
- A. Enable versioning on the S3 bucket.
- B. Enable MFA Delete on the S3 bucket.
- C. Enable S3 Object Lock.
- D. Configure S3 Lifecycle rules.

**Answer: A, B**

**Explanation:** Versioning keeps multiple versions of objects. MFA Delete requires MFA authentication before deletion, providing dual protection.

---

## Topic 44: Data Ingestion with Network Issues

**Scenario:** A data ingestion workflow with SNS and Lambda fails occasionally due to network issues. Lambda doesn't ingest data unless manually rerun.

**Options (Choose two):**
- A. Configure SNS to retry failed Lambda invocations.
- B. Create an SQS queue, subscribe it to SNS topic.
- C. Deploy Lambda on EC2 instances.
- D. Modify Lambda to read from SQS queue.

**Answer: B, D**

**Explanation:** SQS queue decouples the workflow and provides buffering for network issues. Lambda reading from SQS processes with automatic retry.

---

## Topic 45: PII Detection and Alerting

**Scenario:** A company discovers files containing PII were uploaded. They want administrators alerted and automated remediation.

**Options:**
- A. Use Amazon Macie to scan, Lambda to delete objects with PII.
- B. Use Macie to scan, SNS to notify administrators to remove objects.
- C. Deploy third-party PII detection on EC2.
- D. Use AWS Config rules.

**Answer: B**

**Explanation:** Amazon Macie automatically discovers, classifies, and protects sensitive data. When PII is detected, SNS can trigger notifications.

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
| 2 | C | High-Performing |
| 3 | A | Secure |
| 4 | A | Secure |
| 5 | C | High-Performing |
| 6 | B | High-Performing |
| 7 | D | Resilient |
| 8 | B | Resilient |
| 9 | B | Cost-Optimized |
| 10 | B | Resilient |
| 11 | A | Secure |
| 12 | A | High-Performing |
| 13 | A | Secure |
| 14 | C | High-Performing |
| 15 | C | Secure |
| 16 | B | High-Performing |
| 17 | A | Secure |
| 18 | A, B | Resilient |
| 19 | C | Secure |
| 20 | B | High-Performing |
| 21 | C | High-Performing |
| 22 | B | Cost-Optimized |
| 23 | B | Cost-Optimized |
| 24 | A | Cost-Optimized |
| 25 | C | High-Performing |
| 26 | A | Secure |
| 27 | A | Secure |
| 28 | A | Secure |
| 29 | A | Resilient |
| 30 | C | Cost-Optimized |
| 31 | A | Secure |
| 32 | B | Cost-Optimized |
| 33 | C | High-Performing |
| 34 | B | Secure |
| 35 | B | Secure |
| 36 | B | Secure |
| 37 | C | High-Performing |
| 38 | A | High-Performing |
| 39 | A | High-Performing |
| 40 | B | High-Performing |
| 41 | C | Cost-Optimized |
| 42 | B | Cost-Optimized |
| 43 | A, B | Secure |
| 44 | B, D | Resilient |
| 45 | B | Secure |

---

**Good luck with your AWS Solutions Architect Associate exam!**
