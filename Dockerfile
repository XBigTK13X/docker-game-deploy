FROM java:8
LABEL maintainer "xbigtk13x@gmail.com"

RUN dpkg --add-architecture i386

RUN apt-get update && apt-get install git bash zip maven lib32z1 lib32ncurses5 libbz2-1.0:i386 -y

WORKDIR /root

RUN curl -L https://dl.itch.ovh/butler/linux-amd64/head/butler > butler

RUN chmod +x butler

COPY launch4j/ /usr/local/bin/launch4j/

RUN git clone https://github.com/XBigTK13X/conyay.git

COPY start.sh start.sh

RUN chmod +x start.sh

VOLUME [ "/root/source" ]

ENTRYPOINT ["/bin/bash","-c"]

CMD ["/root/start.sh"]
