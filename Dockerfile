FROM centos:centos7

RUN yum update -y && \
yum install -y wget  && \
yum clean all

RUN mkdir -p /opt/grafana
WORKDIR /opt/grafana

RUN wget https://grafanarel.s3.amazonaws.com/builds/grafana-3.1.0-1468321182.linux-x64.tar.gz

RUN tar xzvf grafana-3.1.0-1468321182.linux-x64.tar.gz --strip 1

RUN rm grafana-3.1.0-1468321182.linux-x64.tar.gz

# Expose the ports for inbound events and websockets

EXPOSE 3000
COPY DataSource.json /opt/grafana/DataSource.json
COPY ServerHealthDashboard.json /opt/grafana/ServerHealthDashboard.json
WORKDIR /opt/grafana/bin

CMD ["./grafana-server"]
