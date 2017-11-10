FROM cern/cc7-base
MAINTAINER "Adrian Fiergolski" Adrian.Fiergolski@cern.ch
ENV container docker
COPY eos7-stable.repo /etc/yum.repos.d/eos7-stable.repo 
RUN \
yum install -y epel-release; \
yum install -y initscripts krb5-workstation.x86_64 eos-client zip unzip \
    file git gawk make wget tar bzip2 gzip python34.x86_64 unzip perl patch \
    diffutils diffstat git cpp gcc gcc-c++ glibc-devel texinfo chrpath socat \
    perl-Data-Dumper perl-Text-ParseWords perl-Thread-Queue python3-pip xz \
    which SDL-devel xterm; \
yum clean all; \
rm -rf /var/cache/yum; \
mkdir -m 777 /builds; \ 
useradd -ms /bin/bash caribou; 
USER caribou
WORKDIR /home/caribou
RUN echo "export LC_ALL=en_US.UTF-8" >> ~/.bashrc ; \
echo "export LANG=en_US.UTF-8" >> ~/.bashrc ; \	  
echo "export LANGUAGE=en_US.UTF-8" >> ~/.bashrc ; \
/bin/bash -c 'cd /builds && source <(curl -s https://gitlab.cern.ch/Caribou/meta-caribou/raw/master/misc/setup/setup.sh) "GIT_CI" ' ; \
/bin/bash -c 'cd /builds/poky && source <(curl -s https://gitlab.cern.ch/Caribou/meta-caribou/raw/master/scripts/addCaribouLayer.sh) "GIT_CI" ' ; \
echo 'SSTATE_DIR = "/sstate-cache"' >>  /builds/poky/build/conf/local.conf ; \
echo 'DL_DIR = "/downloads"' >>  /builds/poky/build/conf/local.conf ; 
COPY cern_krb5.conf /etc/krb5.conf.d/cern_krb5.conf
VOLUME [ "/sstate-cache", "/downloads" ]