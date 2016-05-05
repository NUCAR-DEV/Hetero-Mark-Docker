FROM ubuntu:14.04.4
MAINTAINER NUCAR

# OpenCL software stack
RUN apt-get update
RUN cd /tmp && apt-get download fglrx-core && dpkg --force-all -i  fglrx-core*
COPY ./AMDAPPSDK-3.0 /opt/AMDAPPSDK-3.0

ENV AMDAPPSDKROOT /opt/AMDAPPSDK-3.0
ENV PATH /opt/$(AMDAPPSDKROOT)/bin:$PATH

# HSA software stack
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget git cmake g++ python
RUN wget -qO - http://packages.amd.com/rocm/apt/debian/rocm.gpg.key | sudo apt-key add -
RUN sh -c 'echo deb [arch=amd64] http://packages.amd.com/rocm/apt/debian/ trusty main > /etc/apt/sources.list.d/rocm.list'
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y amdcloc

ENV HSA_RUNTIME_PATH /opt/rocm/hsa
ENV PATH /opt/rocm/cloc/bin:$PATH
