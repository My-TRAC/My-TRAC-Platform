FROM java:8-jre

COPY GTFSLoader-1.0-SNAPSHOT-jar-with-dependencies.jar /opt/GTFSLoader/GTFSLoader-1.0-SNAPSHOT-jar-with-dependencies.jar


WORKDIR /opt/GTFSLoader

#ENV ARGS

EXPOSE 4567

#ENTRYPOINT ["java","-jar","GTFSLoader-1.0-SNAPSHOT-jar-with-dependencies.jar]
#CMD [""]

ENTRYPOINT ["java","-jar","GTFSLoader-1.0-SNAPSHOT-jar-with-dependencies.jar"]
#,"-db","connect_test","-ip","$CONNECT_HOST"]
CMD [""]

#,-db connect_test -ip $CONNECT_HOST"]
#CMD ["-db connect_test -ip $CONNECT_HOST]

#CMD ["java","-jar","GTFSLoader-1.0-SNAPSHOT-jar-with-dependencies.jar",$ARGS]
#CMD ["java","-jar","GTFSLoader-1.0-SNAPSHOT-jar-with-dependencies.jar"]
