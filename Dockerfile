FROM alpine:latest
MAINTAINER Richard Kendall <richard.kendall@gmail.com>

ADD https://github.com/richardjkendall/tf-auto-document/releases/download/v1.000/tf-auto-document_v1.000_linux_amd64.tar.gz /tf.tar.gz
RUN tar xvzf /tf.tar.gz
RUN chmod +x /tf-auto-document

LABEL "maintainer"="Richard Kendall <richard.kendall@gmail.com>"

RUN mkdir -p /github/workspace

ADD build.sh /build.sh
RUN chmod +x /build.sh
ENTRYPOINT ["/build.sh"]