-- # 1. Retrieve External ID & IAM Role ARN using DESC INTEGRATION <integration_name> in Snowflake.
-- # 2. Create an IAM Role in AWS that Snowflake can assume for secure S3 access.
-- # 3. Update the IAM Trust Policy to include STORAGE_AWS_EXTERNAL_ID from Snowflake.
-- # 4. Attach an S3 Bucket Policy to grant Snowflake read access (s3:GetObject, s3:ListBucket).
-- # 5. Create an SQS Queue to receive file upload event notifications from S3.
-- # 6. Modify the SQS Access Policy to allow Snowflake to receive messages.
-- # 7. Enable S3 Event Notifications to send 'PUT' event messages to the SQS queue.
-- # 8. Create an External Stage in Snowflake linked to the S3 bucket via the storage integration.
-- # 9. Create a Snowflake PIPE with AUTO_INGEST = TRUE for automatic data loading.

create storage integration spotify_s3
    type = external_stage
    storage_provider = s3
    storage_aws_role_arn = 'Create a role with S3 access and provide the ARN'
    enabled = true
    storage_allowed_locations = ( 's3://spotifydatapipeline-1')

desc integration spotify_s3

CREATE OR REPLACE STAGE spotify_s3_stage
STORAGE_INTEGRATION = spotify_s3
URL = 's3://spotifydatapipeline-1/'

-- TESTING THE INTEGRATION 
COPY INTO tblalbum
FROM @spotify_s3_stage/transformed_data/album_data/
FILE_FORMAT = (TYPE = 'CSV', FIELD_DELIMITER = ',', SKIP_HEADER = 1, FIELD_OPTIONALLY_ENCLOSED_BY='"');

select * from tblalbum
truncate tblalbum

-- /// SNOWPIPES CREATION ///
CREATE or replace pipe album_pipe
    AUTO_INGEST = TRUE AS
    COPY INTO tblalbum
    FROM @spotify_s3_stage/transformed_data/album_data/
    FILE_FORMAT = (TYPE = 'CSV', FIELD_DELIMITER = ',', SKIP_HEADER = 1, FIELD_OPTIONALLY_ENCLOSED_BY='"');

CREATE PIPE or replace artist_pipe
    AUTO_INGEST = TRUE
    AS
    COPY INTO tblartist
    FROM @spotify_s3_stage/transformed_data/artist_data/
    FILE_FORMAT = (TYPE = 'CSV', FIELD_DELIMITER = ',', SKIP_HEADER = 1, FIELD_OPTIONALLY_ENCLOSED_BY='"');

CREATE PIPE song_pipe
    AUTO_INGEST = TRUE
    AS
    COPY INTO tblartist
    FROM @spotify_s3_stage/transformed_data/song_data/
    FILE_FORMAT = (TYPE = 'CSV', FIELD_DELIMITER = ',', SKIP_HEADER = 1, FIELD_OPTIONALLY_ENCLOSED_BY='"');

-- /// TESTING THE PIPES ///

desc PIPE artist_pipe
desc PIPE album_pipe
desc PIPE song_pipe

select$PIPE_STATUS('artist_pipe')
select$PIPE_STATUS('album_pipe')
select$PIPE_STATUS('song_pipe')

