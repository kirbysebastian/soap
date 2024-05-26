FROM ubuntu-base:0.1.0

RUN apt-get install unzip -y

# Flex Dependency
RUN apt install m4

# gSoap Dependency
RUN apt install autoconf -y

ARG deps_dir=/deps
ARG pkgdir=packages

# Copy and isolate packages
COPY ${pkgdir} ${deps_dir}

# Configure and Install Flex
ARG flex=flex-2.6.4
ARG flex_artifact=flex-2.6.4.tar.gz
WORKDIR ${deps_dir}
RUN tar -xzvf ${flex_artifact} \
    && cd ${flex} && ./configure \
    && make -j16 && make install

# Configure and install bison
ARG bison=bison-3.8
ARG bison_artifact=bison-3.8.tar.gz
RUN tar -xzvf ${bison_artifact} \
    && cd ${bison} && ./configure \
    && make -j16 && make install

ARG gsoap=gsoap-2.8
ARG gsoap_artifact=gsoap_2.8.134.zip
RUN unzip ${gsoap_artifact} \
    && cd ${gsoap} && ./configure \
    && make -j16 && make install