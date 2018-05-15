FROM confluentinc/cp-kafka-connect:4.0.0


RUN mkdir -p /etc/kafka-connect/jars


COPY mysql-connector-java-5.1.39-bin.jar /etc/kafka-connect/jars

#RUN apt-get update && \
#      apt-get -y install sudo
#
#RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
#
#RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
#
#USER docker
#
#RUN sudo sysctl -w vm.max_map_count=262144

