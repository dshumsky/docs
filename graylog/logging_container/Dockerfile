FROM alpine

RUN apk add jq

COPY output.txt /output.txt
COPY output.json /output.json

COPY run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]
# ENTRYPOINT ["tail", "-f", "/dev/null"]
