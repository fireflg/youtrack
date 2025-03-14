FROM java:8-jre

RUN mkdir -p /opt/youtrack/data /opt/youtrack/backup /opt/youtrack/bin

WORKDIR /opt/youtrack

ENV YOUTRACK_VERSION 2021.4.31698

RUN apt-get update && \
    apt-get install -y supervisor && \
    rm -rf /var/lib/apt/lists/*

ADD supervisor/youtrack.conf /etc/supervisor/conf.d/youtrack.conf

RUN wget --no-verbose \
 https://download.jetbrains.com/charisma/youtrack-${YOUTRACK_VERSION}.jar \
 -O /opt/youtrack/bin/youtrack.jar

EXPOSE 443/tcp

VOLUME ["/opt/youtrack/data/", "/opt/youtrack/backup/"]

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]