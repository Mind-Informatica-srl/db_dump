#!/bin/sh

# Ensure all required environment variables are set
: "${PGHOST:?Need to set PGHOST}"
: "${PGPORT:?Need to set PGPORT}"
: "${PGUSER:?Need to set PGUSER}"
: "${PGPASSWORD:?Need to set PGPASSWORD}"
: "${PGDATABASE:?Need to set PGDATABASE}"
: "${FTP_HOST:?Need to set FTP_HOST}"
: "${FTP_USER:?Need to set FTP_USER}"
: "${FTP_PASSWORD:?Need to set FTP_PASSWORD}"
: "${FILE_PREFIX:?Need to set FILE_PREFIX}"

# Generate the filename with prefix and current date/time
FILENAME="${FILE_PREFIX}_$(date +%Y%m%d_%H%M%S).sql"

# Perform the database dump
pg_dump -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" -d "$PGDATABASE" -v > "/tmp/$FILENAME"

# Upload the dump to the FTP server
curl -T "/tmp/$FILENAME" --user "$FTP_USER:$FTP_PASSWORD" "ftp://$FTP_HOST/"

# Clean up
rm "/tmp/$FILENAME"