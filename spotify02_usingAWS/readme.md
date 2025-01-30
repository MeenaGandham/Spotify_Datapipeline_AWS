# DATA PIPELINE USING AWS S3, LAMBDA, CLOUDWATCH, CRAWLERS AND ATHENA.
![Architecture](https://github.com/MeenaGandham/Spotify_Datapipelines/blob/main/spotify02_usingAWS/python.png?raw=true)
## OVERVIEW 
This pipeline automates the process of extracting, transforming, and loading (ETL) Spotify data using AWS services. It ensures efficient data processing and analytics through AWS Lambda, S3, Glue, and Athena.
## Pipeline Workflow
- Extract : AWS Lambda fetches data from the Spotify API and stores it in Amazon S3 (raw data). Trigger: Amazon CloudWatch is used to schedule daily extraction.
- Transform: Another AWS Lambda function processes and transforms raw data before storing it in a transformed S3 bucket. Trigger: An S3 event trigger automatically invokes this Lambda function whenever new raw data is added.
- Load: AWS Glue Crawlers infer the schema of transformed data and store metadata in AWS Glue Data Catalog. Data is then made available for querying using Amazon Athena.

