FROM tiredofit/alpine:3.12
LABEL maintainer="Dave Conroy (dave at tiredofit dot ca)"

### Disable Features from Base Image
   ENV ENABLE_SMTP=FALSE
   
### Add Minio User
   RUN set -x && \
       addgroup -g 9000 minio && \
       adduser -S -D -H -h /config -s /sbin/nologin -G minio -u 9000 minio && \
       \
### Install Dependencies
       apk update && \
       apk upgrade && \
       \
### Fetch Minio
       wget https://dl.min.io/server/minio/release/linux-amd64/minio -O /usr/sbin/minio && \
       chmod +x /usr/sbin/minio && \
       \
### Additional Steps
       mkdir -p /config && \
       mkdir -p /data && \
       chown -R minio:minio /config /data && \
       cd / && \
### Cleanup
       rm -rf /var/cache/apk/*

### Volume Information
   VOLUME ["/data"]

### Networking Configuration
   EXPOSE 9000 9001 9002 9003 9004 9005

### Add Files
   ADD install /


