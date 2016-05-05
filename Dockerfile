FROM ubuntu:14.04.4
MAINTAINER NUCAR

# For build testing purpose, need OpenCL 1.2/2.0 and HSA software stack
RUN apt-get update
RUN apt-get install -y wget git cmake g++ python
RUN wget -qO - http://packages.amd.com/rocm/apt/debian/rocm.gpg.key | sudo apt-key add -
RUN sh -c 'echo deb [arch=amd64] http://packages.amd.com/rocm/apt/debian/ trusty main > /etc/apt/sources.list.d/rocm.list'
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y fglrx rocm amdcloc

# Set up some environment variables
ENV HSA_RUNTIME_PATH=/opt/rocm/hsa
ENV PATH=/opt/rocm/cloc/bin:$PATH

