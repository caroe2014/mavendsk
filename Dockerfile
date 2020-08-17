FROM maven:3.6.3-jdk-11

WORKDIR /azp

# COPY ./config.sh .
COPY ./start.sh .
RUN chmod +x start.sh

ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

RUN wget http://ftp.us.debian.org/debian/pool/main/i/icu/libicu57_57.1-6+deb9u4_amd64.deb
RUN dpkg -i libicu57_57.1-6+deb9u4_amd64.deb
RUN wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb

RUN apt-get update \
&& apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        jq \
        git \
        iputils-ping \
        dotnet-sdk-3.1 \
        libcurl4 \
        libicu-dev \
        libunwind8 \
        netcat
        # software-properties-common \
        # python3.6

EXPOSE 8080

# CMD ["python3 -m http.server 3000 &"]

CMD ["./start.sh"]
