# Kafka Schema Registry

## Introduction

The Schema registry is a service that runs in the Kafka cluster that provides a RESTful interface for storing and retrieving Avro schemas. It is used to enforce schema rules for Kafka topics and can version schemas.

## Bullet points

- Both Consumers and Producers retrieve schemas from the Schema Registry via HTTPS calls that are then cached locally.
- It supports full serialization for Avro and Protobuf schemas. It also supports JSON Schema but only as a specification. (I guess this means JSON is not encouraged for use with the Schema Registry).
- Avro Schemas are stored in the Schema Registry in JSON format.
- When a new version of a schema is registered, it is assigned an incremended version number, starting at 1. This way you can have multiple versions of the same schema and only the latest version is used for new messages.

In code when you have already set up the Schema Registry URLs, you can just use the following to produce/consume messages using the latest schema:

```java
// Producer
configs.put("value.serializer", KafkaAvroSerializer.class);

Producer<TopicName> producer = new KafkaProducer<>(configs);
```

### Schema Lifecycle

1. Producer needs to serialize the data before sending it to Kafka. It needs to know the schema of the data. 
2. Serializer checks if the schema is already in the local cache. If not, it retrieves it from the Schema Registry and stores its unique ID in the local cache.
3. The data is serialized with the schema ID and sent to Kafka.

> Note: The same process happens for the Consumer, except it deserializes the data and nothing is sent to Kafka.