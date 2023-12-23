# Use Alpine Linux as the base image
FROM alpine:latest

# Install autossh
RUN apk add --no-cache autossh

# Copy the script and configuration file (to be created in the next steps)
COPY start-tunnels.sh /start-tunnels.sh
COPY config.yaml /config.yaml

# Set execute permissions on the script
RUN chmod +x /start-tunnels.sh

# Set the default command to execute the script
CMD ["/start-tunnels.sh"]
