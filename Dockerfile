FROM ubuntu:xenial

MAINTAINER PhenoMeNal-H2020 Project ( phenomenal-h2020-users@googlegroups.com )

# Stay up-to-date
RUN apt-get update && \
	apt-get install -y \
	octave \
	inkscape \
	pdftk \
	git && \
	apt-get -y clean && \
	apt-get -y autoremove && \
	rm -rf /var/lib/{cache,log}/ /tmp/* /var/tmp/*

LABEL software="metabomatching"
LABEL base.image="ubuntu:xenial"
LABEL decription="metabomatching"
LABEL website="https://www2.unil.ch/cbg/index.php?title=Metabomatching"
LABEL documentation="https://github.com/rrueedi/metabomatching/tree/master/documentation"
LABEL documentation="https://github.com/rrueedi/metabomatching"
LABEL tags="metabomatching"
LABEL software.version="0.2.1"
LABEL version="0.4.1"

ENV TOOL_VERSION=0.2.1
ENV CONTAINER_VERSION=0.4.1
ENV TRIGGER_JENKINS=1

# Install metabomatching
RUN git clone -b release/${TOOL_VERSION} https://github.com/rrueedi/metabomatching.git /mm-tp/
RUN cp -r /mm-tp/fos /usr/share/fonts/truetype/
RUN fc-cache -f -v

ENV PATH=$PATH:/mm-tp

# Uncomment the entrypoint in order to use the tool with Galaxy
ENTRYPOINT ["metabomatching.sh"]
