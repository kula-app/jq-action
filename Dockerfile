# syntax=docker/dockerfile:1

FROM alpine:3.21

# Install dependencies
RUN apk add --no-cache jq

# Copy entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
