
kubectl exec $1 -- kafka-avro-console-consumer --zookeeper \
cigo-zookeeper-svc.default.svc.cluster.local:32181 --topic $2 --from-beginning \
--property print.key=true \
--property key.deserializer=org.apache.kafka.common.serialization.StringDeserializer \
--property schema.registry.url=http://cigo-schema-registry-svc.default.svc.cluster.local:8081
