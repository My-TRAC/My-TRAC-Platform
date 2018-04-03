#
# Copyright 2016 Confluent Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM debian:jessie

ARG COMMIT_ID=unknown
LABEL io.confluent.docker.git.id=$COMMIT_ID
ARG BUILD_NUMBER=-1
LABEL io.confluent.docker.build.number=$BUILD_NUMBER

ARG CIGO_PACKAGES_REPO=$CIGO_PACKAGES_REPO

ARG ALLOW_UNSIGNED=false
#Set an env var so that it's available in derived images
ENV ALLOW_UNSIGNED=$ALLOW_UNSIGNED

MAINTAINER partner-support@confluent.io
LABEL io.confluent.docker=true

# Python
ENV PYTHON_VERSION="2.7.9-1"
ENV PYTHON_PIP_VERSION="8.1.2"

# Confluent
ENV SCALA_VERSION="2.11"

ARG KAFKA_VERSION=$KAFKA_VERSION
ARG CIGO_MAJOR_VERSION=$CIGO_MAJOR_VERSION
ARG CIGO_MINOR_VERSION=$CIGO_MINOR_VERSION
ARG CIGO_PATCH_VERSION=$CIGO_PATCH_VERSION

ARG CIGO_MVN_LABEL=$CIGO_MVN_LABEL
ARG CIGO_PLATFORM_LABEL=$CIGO_PLATFORM_LABEL

ENV KAFKA_VERSION=$KAFKA_VERSION
ENV CIGO_MAJOR_VERSION=$CIGO_MAJOR_VERSION
ENV CIGO_MINOR_VERSION=$CIGO_MINOR_VERSION
ENV CIGO_PATCH_VERSION=$CIGO_PATCH_VERSION

ENV CIGO_MVN_LABEL=$CIGO_MVN_LABEL
ENV CIGO_PLATFORM_LABEL=$CIGO_PLATFORM_LABEL

ENV CIGO_VERSION="$CIGO_MAJOR_VERSION.$CIGO_MINOR_VERSION.$CIGO_PATCH_VERSION"
ENV CIGO_DEB_VERSION="1"

# Zulu
ENV ZULU_OPENJDK_VERSION="8=8.17.0.3"

# This affects how strings in Java class files are interpreted.  We want UTF-8 and this is the only locale in the
# base image that supports it
ENV LANG="C.UTF-8"

RUN echo "===> Updating debian ....." \
    && apt-get -qq update \
    \
    && echo "===> Installing curl wget netcat python...." \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
                apt-transport-https \
                curl \
                wget \
                netcat \
                python=${PYTHON_VERSION}
    RUN echo "===> Installing python packages ..."  \
    && curl -fSL "https://bootstrap.pypa.io/get-pip.py" | python \
    && pip install --no-cache-dir --upgrade pip==${PYTHON_PIP_VERSION} \
    && pip install --no-cache-dir jinja2 \
                                  requests 

    RUN echo "Installing Zulu OpenJDK ${ZULU_OPENJDK_VERSION}" \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9\ 
    && echo "deb http://repos.azulsystems.com/debian stable  main" >> /etc/apt/sources.list.d/zulu.list \
    && apt-get -qq update \
    && apt-get -y install zulu-${ZULU_OPENJDK_VERSION} \
    && rm -rf /var/lib/apt/lists/* 


    RUN echo "===> Adding confluent repository...${CIGO_PACKAGES_REPO}/deb/${CIGO_MAJOR_VERSION}.${CIGO_MINOR_VERSION}" \
    && if [ "x$ALLOW_UNSIGNED" = "xtrue" ]; then echo "APT::Get::AllowUnauthenticated \"true\";" > /etc/apt/apt.conf.d/allow_unauthenticated; else curl -L ${CIGO_PACKAGES_REPO}/deb/${CIGO_MAJOR_VERSION}.${CIGO_MINOR_VERSION}/archive.key | apt-key add - ; fi \
    && echo "deb [arch=amd64] ${CIGO_PACKAGES_REPO}/deb/${CIGO_MAJOR_VERSION}.${CIGO_MINOR_VERSION} stable main" >> /etc/apt/sources.list

COPY include/dub /usr/local/bin/dub
COPY include/cub /usr/local/bin/cub
COPY include/etc/confluent/docker /etc/confluent/docker
