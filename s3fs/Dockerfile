FROM node:stretch

EXPOSE 3282

RUN apt update && apt install -y --no-install-recommends s3fs && rm -rf /var/lib/apt/lists/*

ENV FEEDS_DAT=""
ENV FEEDS_FILE=feeds
ENV S3ACCESSKEY=""
ENV S3SECRETKEY=""
ENV S3BUCKET=""

RUN npm install -g dat https://github.com/amarburg/hypercored.git

ADD run.sh /root/run.sh
RUN chmod 755 /root/run.sh

ENTRYPOINT ["/root/run.sh"]
