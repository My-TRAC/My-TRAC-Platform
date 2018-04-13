FROM confluentinc/cp-kafka:4.0.0

RUN mkdir scripts

COPY createTopics.sh scripts
RUN chmod +x scripts/*
CMD ["./scripts/createTopics.sh"]
CMD ["sleep", "infinity"]

