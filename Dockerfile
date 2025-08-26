FROM python:3.9-alpine

LABEL maintainer "https://github.com/camAtGitHub"

ENV ENDPOINT="192.168.99.100:9200"
ENV CREDENTIALS=""
ENV CLUSTERHEALTH=""
ENV PIPELINE="--pipeline=benchmark-only"
ENV RALLYCONFIG="rally.ini"
ENV RALLYVER="2.12.0"
ENV HTTPPROXY=""
ENV REPORTFMT="markdown"

RUN apk add --update --no-cache git build-base linux-headers python-dev openjdk8
RUN pip install esrally==$RALLYVER
RUN export http_proxy=$HTTPPROXY
RUN if [ -n "$HTTPPROXY" ]; then git config --global http.proxy $HTTPPROXY; fi

COPY config/$RALLYCONFIG /root/.rally/

CMD esrally $PIPELINE --target-hosts=$ENDPOINT $CREDENTIALS $CLUSTERHEALTH --report-format=$REPORTFMT
