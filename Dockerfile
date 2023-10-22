FROM alpine
WORKDIR /install
RUN wget 'https://atxfiles.netgate.com/mirror/downloads/pfSense-CE-2.7.0-RELEASE-amd64.iso.gz'
RUN gzip -d pfSense-CE-2.7.0-RELEASE-amd64.iso.gz

