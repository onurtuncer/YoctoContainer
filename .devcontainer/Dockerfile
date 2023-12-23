#------------------------------------------------------------------------------------------------------------
#  Copyright 2023, Onur Tuncer

#  Written by Onur Tuncer, Istanbul Technical University, Turkey
#  Contact tuncero@itu.edu.tr
#------------------------------------------------------------------------------------------------------------


# https://koansoftware.com/howto-use-yocto-project-with-the-stm32mp1-embedded-systems/

# [Choice] Debian / Ubuntu version: e.g debian-10, debian-9
ARG VARIANT=ubuntu-18.04
FROM mcr.microsoft.com/vscode/devcontainers/base:${VARIANT}

LABEL maintainer="tuncero@itu.edu.tr" \
      url="https://avesis.itu.edu.tr/tuncero" \
      name="yocto_stm32" \
      description="Yocto build container for STM32MP157"

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -y upgrade
ARG UID=1001

# Install needed packages. Use a separate RUN statement to add your own dependencies.
RUN echo "Installing basic developer tools" \
    && apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install \
                gawk \
                wget \
                git-core \
                diffstat \
                unzip \
                texinfo \
                gcc-multilib \
                build-essential \
                chrpath \
                socat \
                cpio \
				file \
				locales \
				zstd \
				liblz4-tool \
				git \ 
				python \
	&& apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

RUN echo "Installing python3" \
    && apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install \
    			python3 \
                python3-pip \
				python3-jinja2 \
                python3-pexpect \
				python3-subunit \
                xz-utils \
                debianutils \
                iputils-ping \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

RUN echo "Installing libsdl1 & xterm" \ 
	&& apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install \
				libsdl1.2-dev \
				xterm \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

RUN echo "Installing make, xsltproc, docbook-utils, fop, dblatex, xmlto" \ 
	&& apt-get update  \
	&& export DEBIAN_FRONTEND=noninteractive \
    	&& apt-get -y install \
				make \
				xsltproc \
				docbook-utils \
				fop \
				dblatex \
				xmlto \		
    	&& apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

RUN echo "Installing python-git" \ 
	&& apt-get update \
	&& export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install \
				python3-git \
    	&& apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

RUN echo "Installing even more stuff" \ 
	&& apt-get update \
	&& export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install \
				coreutils \
				bsdmainutils \
				sed \
				bc \
				lrzsz \
				corkscrew \
				cvs \
				subversion \
				mercurial \
				nfs-common \
				nfs-kernel-server \
				libarchive-zip-perl \
				dos2unix \
				texi2html \
				diffstat \
				libxml2-utils \
    	&& apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

RUN echo "Installing even more stuff" \ 
	&& apt-get update \
	&& export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install \
				curl \
				bsdmainutils \
				libsdl2-2.0-0 \
    	&& apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# # Additional host packages required by poky/scripts/wic
# RUN apt-get install -y curl dosfstools mtools parted syslinux tree tzdata vim libtool libsdl2-2.0-0

# Add "repo" tool (used by many Yocto-based projects)
RUN curl http://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo
RUN chmod a+x /usr/local/bin/repo

RUN rm /bin/sh && ln -s bash /bin/sh

RUN locale-gen en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENV USER_NAME stm32mp157
ENV PROJECT   stm32mp157

# Create user "user"
RUN id user 2>/dev/null || useradd --uid $UID --create-home user

# Create a non-root user that will perform the actual build
RUN apt-get install -y sudo
RUN echo "user ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers

USER user

# ENV BUILD_INPUT_DIR /home/${USER_NAME}/yocto/input
# ENV BUILD_OUTPUT_DIR /home/${USER_NAME}/yocto/output
# RUN mkdir -p $BUILD_INPUT_DIR $BUILD_OUTPUT_DIR

# WORKDIR $BUILD_OUTPUT_DIR
# ENV TEMPLATECONF=$BUILD_INPUT_DIR/$PROJECT/sources/meta-$PROJECT/custom
# CMD source $BUILD_INPUT_DIR/$PROJECT/sources/poky/oe-init-build-env \
#     build && bitbake $PROJECT-image