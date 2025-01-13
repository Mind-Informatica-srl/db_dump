FROM alpine:latest

# Install necessary packages
RUN apk add --no-cache postgresql-client curl

# Copy the script into the container
COPY backup.sh /usr/local/bin/backup.sh

# Make the script executable
RUN chmod +x /usr/local/bin/backup.sh

# Set the entrypoint to the script
ENTRYPOINT ["/usr/local/bin/backup.sh"]