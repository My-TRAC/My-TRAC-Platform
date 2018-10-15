FROM java:8-jre

#COPY scripts  /usr/bin

COPY resources /opt/RatingModelerCSV/
COPY  RatingModelerCSV-1.0-SNAPSHOT-jar-with-dependencies.jar /opt/RatingModelerCSV/RatingModelerCSV-1.0-SNAPSHOT-jar-with-dependencies.jar
COPY run.sh /opt/RatingModelerCSV/run.sh
RUN chmod +x /opt/RatingModelerCSV/run.sh
WORKDIR /opt/RatingModelerCSV



ENTRYPOINT ["/opt/RatingModelerCSV/run.sh"]
CMD [""]

