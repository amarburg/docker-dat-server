FROM node:10

VOLUME /data
EXPOSE 3282

ENV FEEDS_DAT=""
ENV FEEDS_FILE=feeds

RUN npm install -g dat https://github.com/amarburg/hypercored.git

ADD run.sh /root/run.sh
RUN chmod 755 /root/run.sh

ENTRYPOINT ["/root/run.sh"]
