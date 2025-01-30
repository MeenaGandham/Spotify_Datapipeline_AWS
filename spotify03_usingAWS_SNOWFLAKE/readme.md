# DATA PIPELINE USING AWS S3, LAMBDA, CLOUDWATCH, SNOWFLAKE AND SNOWPIPE. 
![Architecture](https://github.com/MeenaGandham/Spotify_Datapipelines/blob/main/spotify03_usingAWS_SNOWFLAKE/snowflake%202.png?raw=true)
## This pipeline automates the process of extracting, transforming, and loading (ETL) Spotify data using AWS services and Snowflake. It ensures efficient data processing and analytics by leveraging AWS Lambda, S3, Snowpipe, and Snowflake.
##Pipeline Workflow :
- Extract: AWS Lambda fetches data from the Spotify API and stores it in Amazon S3 (raw data). Trigger: Amazon CloudWatch is used to schedule daily extraction.
- Transform: Another AWS Lambda function processes and transforms raw data before storing it in a transformed S3 bucket.Trigger: An S3 event trigger automatically invokes this Lambda function whenever new raw data is added.
- Load: Transformed data from S3 is loaded into Snowflake using Snowpipe, which automates continuous data ingestion. Snowflake stores and makes the data available for analysis.
