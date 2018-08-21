FROM java:8-jre

#COPY scripts  /usr/bin


COPY  RatingModeler-1.0-SNAPSHOT-jar-with-dependencies.jar /opt/RatingModeler/RatingModeler-1.0-SNAPSHOT-jar-with-dependencies.jar
COPY run.sh /opt/RatingModeler/run.sh
COPY scripts /opt/RatingModeler/scripts
RUN chmod -R +x /opt/RatingModeler/scripts
RUN chmod +x /opt/RatingModeler/run.sh
WORKDIR /opt/RatingModeler


EXPOSE 4567

ENTRYPOINT ["/opt/RatingModeler/run.sh"]
CMD [""]

