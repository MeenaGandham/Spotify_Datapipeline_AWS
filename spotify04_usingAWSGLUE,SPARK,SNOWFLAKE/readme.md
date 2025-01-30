# DATA PIPELINE USING AWS S3, LAMBDA, CLOUDWATCH, GLUE, SPARK, SNOWFLAKE AND SNOWPIPE.
This pipeline automates the process of extracting, transforming, and loading (ETL) Spotify data using AWS services and Snowflake. It ensures efficient data processing and analytics by leveraging AWS Lambda, S3, Glue (with Apache Spark), Snowpipe, and Snowflake.

![Architecture](https://github.com/MeenaGandham/Spotify_Datapipelines/blob/main/spotify04_usingAWSGLUE,SPARK,SNOWFLAKE/glue_spark%202.png?raw=true)

## Pipeline Workflow
- Extract: AWS Lambda fetches data from the Spotify API and stores it in Amazon S3 (raw data). Trigger: Amazon CloudWatch is used to schedule daily extraction.
- Transform: AWS Glue (powered by Apache Spark) processes and transforms raw data before storing it in a transformed S3 bucket. Trigger: An S3 event trigger automatically invokes the Glue job whenever new raw data is added. Partitioning: Data in Spark will be transformed and stored in S3 in folder containing partitions to optimize query performance and reduce processing costs.
- Load: Transformed data from S3 is loaded into Snowflake using Snowpipe, which automates continuous data ingestion. Snowflake stores and makes the data available for analysis.
