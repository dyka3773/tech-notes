<!-- omit from toc -->
# Apache Kafka

<!-- omit from toc -->
## Table of Contents
- [Introduction](#introduction)
- [Architecture](#architecture)
  - [Producers](#producers)
  - [Consumers](#consumers)
  - [Schema Registry](#schema-registry)
  - [Other Useful Tools](#other-useful-tools)
- [Noteworthy Configurations](#noteworthy-configurations)
  - [Auto Create Topics and Schemas](#auto-create-topics-and-schemas)
  - [Testing the Producer](#testing-the-producer)
  - [Testing `auto.register.schemas=false` or `auto.create.topics.enable=false`](#testing-autoregisterschemasfalse-or-autocreatetopicsenablefalse)
- [Resources](#resources)
    - [E-Books](#e-books)
    - [Documentation](#documentation)
    - [Videos](#videos)


## Introduction

Apache Kafka is a distributed streaming platform. 
It is used for building real-time data pipelines and streaming apps. 
It is horizontally scalable, can support fault-tolerance. 
It uses a pub-sub messaging system like Message Queues, but the messages are not popped out of the queue once consumed.
There is a retention period for the messages, after which they are deleted.
There is the concept of consumer groups, where multiple consumers can consume messages from the same topic in parallel even if they are on the same machine.
There is also the concept of partitions, where a topic can be divided into multiple partitions for fault-tolerance and parallelism.
The partitions are distributed across the brokers in a cluster.
The messages are ordered within a partition, but not across partitions.
They are stored in the partitions in an append-only fashion and are immutable.
They are also stored in an ordered fashion using an offset.


## Architecture

To the Kafka application, everything is either a producer, a consumer, or a broker.
The producers and consumers are the clients of the Kafka application.
The brokers are the servers that form the Kafka cluster.
The Producers and Consumers can be written in any language that supports the Kafka API (Java, Python, Go, etc.) or can use the REST API that Kafka provides.
The Kafka cluster can be deployed on-premise or on the cloud (It usually is a docker container).
It also supports other 3rd party tools like Schema Registry, REST Proxy, etc. that can be used to manage the Kafka cluster. (I'll talk about them later)

### Producers

The producers are the clients that send messages to the Kafka cluster.
They can send messages to a specific topic or a partition of a topic.
Where the message is sent depends on the partitioning strategy used and the key of the message which is optional.
The partitioning strategy can be round-robin (no-key) or based on the key of the message (or any other custom strategy).
Their usual configuration is something like this:
```properties
bootstrap.servers=localhost:9092
key.serializer=org.apache.kafka.common.serialization.StringSerializer
value.serializer=org.apache.kafka.common.serialization.StringSerializer

topic.name=first_topic
```

The `bootstrap.servers` is the address of the Kafka cluster.
The `key.serializer` and `value.serializer` are the serializers for the key and value of the message.
The serializers are used to convert the key and value of the message to bytes before sending them to the Kafka cluster.
The `value.serializer` can be almost anything, but the usual scenarios are:
- `org.apache.kafka.common.serialization.StringSerializer` for string messages (UTF-8) that have no real structure
- `io.confluent.kafka.serializers.KafkaAvroSerializer` for messages that have a schema (like JSON, XML, etc.), where the schema is stored in the Schema Registry (see [this](#schema-registry)), and the messages are serialized using the Avro serialization format.
- `io.confluent.kafka.serializers.KafkaJsonSerializer` for messages that have a schema (like JSON, XML, etc.), where the schema is stored in the Schema Registry (see [this](#schema-registry)), and the messages are serialized using the JSON serialization format.
- `io.confluent.kafka.serializers.protobuf.KafkaProtobufSerializer` for messages that have a schema (like JSON, XML, etc.), where the schema is stored in the Schema Registry (see [this](#schema-registry)), and the messages are serialized using the Protobuf serialization format.

The `topic.name` is the name of the topic to which the messages will be sent.
This is not required by the producer, but by the ProducerRecord that is used to send the messages to the Kafka cluster so it will definetly be needed in the code.

> Note: In the case of the Avro, JSON, and Protobuf serializers, the schema is stored in the Schema Registry, and the messages are serialized using the schema. This means that another property is needed to specify the address of the Schema Registry. The property is `schema.registry.url`.

Let's take a look at a simple producer example in Java:

```java
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.clients.producer.RecordMetadata;

import java.util.Properties;
import java.util.concurrent.ExecutionException;


public class ProducerDemo {
    public static void main(String[] args) throws ExecutionException, InterruptedException {
        // Create Producer Properties
        Properties properties = new Properties();
        properties.setProperty("bootstrap.servers", "localhost:9092");
        properties.setProperty("key.serializer", org.apache.kafka.common.serialization.StringSerializer.class);
        properties.setProperty("value.serializer", org.apache.kafka.common.serialization.StringSerializer.class);
        properties.setProperty("topic.name", "first_topic")

        // Create the Producer
        KafkaProducer<String, String> producer = new KafkaProducer<>(properties); // The KafkaProducer will ignore any properties that are not needed

        // Create a Producer Record
        ProducerRecord<String, String> record = new ProducerRecord<>(properties.getProperty("topic.name"), "hello world"); // This means that the value of the message is "hello world" and that it will be sent to the topic "first_topic" (the key is null)

        // Send Data - Asynchronous
        producer.send(record, (RecordMetadata recordMetadata, Exception e) -> { // Callback function that is executed every time a record is sent or an exception is thrown while sending the record
            if (e == null) {
                System.out.println("Received new metadata. \n" +
                        "Topic: " + recordMetadata.topic() + "\n" +
                        "Partition: " + recordMetadata.partition() + "\n" +
                        "Offset: " + recordMetadata.offset() + "\n" +
                        "Timestamp: " + recordMetadata.timestamp());
            } else {
                System.out.println("Error while producing: " + e);
            }
        }).get(); // block the .send() to make it synchronous - don't do this in production!

        // Flush Data
        producer.flush();

        // Flush and Close Producer
        producer.close();
    }
}
```

A similar example in Python:

```python
from kafka import KafkaProducer
from kafka.errors import KafkaError

properties: dict = {
    "bootstrap.servers": "localhost:9092",
    "topic.name": "first_topic"
}

producer = KafkaProducer(
    bootstrap_servers=properties["bootstrap.servers"],
    key_serializer=str.encode,
    value_serializer=str.encode
)

# The b'hello world' means that the value of the message is "hello world" and that it will be sent to the topic "first_topic" (the key is null)
future = producer.send(properties["topic.name"], b'hello world')

try:
    record_metadata = future.get(timeout=10)

    print(record_metadata.topic)
    print(record_metadata.partition)
    print(record_metadata.offset)
except KafkaError as e:
    print(e)


producer.flush()
producer.close()
```

> Note: For the Python example, I'm using the [kafka-python] library. 
> It is not the official library, but it is the most popular one.


### Consumers

Consumers are the clients that consume messages from the Kafka cluster.
They can consume messages from a specific topic or a partition of a topic.
Where the message is consumed from depends on the consumer group that the consumer belongs to. (This means that every consumer must belong to a consumer group)
The consumer group is a logical grouping of consumers that consume messages from the same topic.
Each consumer group has a unique group id.
Usually, each consumer commits the offset of the last message that it consumed to the Kafka cluster so that if it crashes, the next consumer that belongs in the same group will know from where to start consuming messages.
Their usual configuration is something like this:
```properties
bootstrap.servers=localhost:9092
key.deserializer=org.apache.kafka.common.serialization.StringDeserializer
value.deserializer=org.apache.kafka.common.serialization.StringDeserializer

topic.name=first_topic
group.id=my-consumer-group
auto.offset.reset=earliest
```

The `bootstrap.servers` is the address of the Kafka cluster.
The `key.deserializer` and `value.deserializer` are the deserializers for the key and value of the message.
The deserializers are used to convert the bytes of the key and value of the message to the actual key and value of the message after receiving them from the Kafka cluster.
The `value.deserializer` must be the same as the `value.serializer` of the producer that sent the message.(see [Kafka Producers](#producers))
The `topic.name` is the name of the topic from which the messages will be consumed.
The `group.id` is the id of the consumer group to which the consumer belongs.
The `auto.offset.reset` is the offset from where the consumer will start consuming messages if it is the first time that it is consuming messages from the topic or if no offset was committed to the Kafka cluster. Its possible values are:
- `earliest` - the consumer will start consuming messages from the beginning of the topic
- `latest` - the consumer will start consuming messages from the end of the topic
- `none` - the consumer will throw an error if no offset was committed to the Kafka cluster

Let's take a look at a simple consumer example in Java:

```java
import org.apache.kafka.clients.consumer.ConsumerConfig;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.apache.kafka.clients.consumer.ConsumerRecords;
import org.apache.kafka.clients.consumer.KafkaConsumer;

import java.time.Duration;
import java.util.Collections;
import java.util.Properties;


public class ConsumerDemo {
    public static void main(String[] args) {
        // Create Consumer Properties
        Properties properties = new Properties();
        properties.setProperty(ConsumerConfig.BOOTSTRAP_SERVERS_CONFIG, "localhost:9092");
        properties.setProperty(ConsumerConfig.KEY_DESERIALIZER_CLASS_CONFIG, org.apache.kafka.common.serialization.StringDeserializer.class);
        properties.setProperty(ConsumerConfig.VALUE_DESERIALIZER_CLASS_CONFIG, org.apache.kafka.common.serialization.StringDeserializer.class);
        properties.setProperty(ConsumerConfig.GROUP_ID_CONFIG, "my-consumer-group");
        properties.setProperty(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "earliest");
        properties.setProperty("topic.name", "first_topic");

        // Create the Consumer
        KafkaConsumer<String, String> consumer = new KafkaConsumer<>(properties);

        // Subscribe Consumer to a Topic
        consumer.subscribe(properties.getProperty("topic.name"));

        // Poll for new Data
        while (true) {
            ConsumerRecords<String, String> records = consumer.poll(Duration.ofMillis(100)); // new in Kafka 2.0.0
            for (ConsumerRecord<String, String> record : records) {
                System.out.println("Key: " + record.key() + ", Value: " + record.value());
                System.out.println("Partition: " + record.partition() + ", Offset: " + record.offset());
            }
        }
    }
}
```

A similar example in Python:

```python
from kafka import KafkaConsumer
from kafka.errors import KafkaError

properties: dict = {
    "bootstrap.servers": "localhost:9092",
    "group.id": "my-consumer-group",
    "auto.offset.reset": "earliest",
    "topic.name": "first_topic"
}

consumer = KafkaConsumer(
    properties["topic.name"],
    bootstrap_servers=properties["bootstrap.servers"],
    group_id=properties["group.id"],
    auto_offset_reset=properties["auto.offset.reset"],
    key_deserializer=str.decode,
    value_deserializer=str.decode
)

for message in consumer:
    print(message.topic)
    print(message.partition)
    print(message.offset)
    print(message.key)
    print(message.value)


consumer.close() # This will commit the offset of the last message that was consumed
```


### Schema Registry

The Schema Registry is a service that is used to store the schemas of the messages that are sent to the Kafka cluster.
It is used by the producers and consumers that use the Avro, JSON, or Protobuf serializers.
It is not required by the producers and consumers, but it is highly recommended to use it because it provides type safety and compatibility between different consumers and producers (or applications in general).
It is usually deployed as a docker container and usually on the same machine as the Kafka cluster.
It is also usually deployed with the REST Proxy (see [Other Useful Tools](#other-useful-tools)).

The Schema Registry has a REST API that can be used to manage the schemas.
The most important endpoints are:
- `POST /subjects/{subject}/versions` - used to register a new schema for a subject
- `GET /subjects/{subject}/versions/{version}` - used to get a specific version of a schema for a subject
- `GET /subjects/{subject}/versions` - used to get all the versions of a schema for a subject
- `GET /subjects/{subject}/versions/{version}/schema` - used to get the schema of a specific version of a schema for a subject

In it simplest form, the schema is just a JSON object that describes the structure of the message.
For example, the schema for a message that has a `name` and an `age` field that are both strings would be:

```json
{
  "type": "record",
  "name": "Person",
  "namespace": "com.example",
  "fields": [
    {
      "name": "name",
      "type": "string"
    },
    {
      "name": "age",
      "type": "string"
    }
  ]
}
```

The schema is usually stored in a file with the `.avsc` extension.

There are also tools to generate a metaclass from the schema that can be used to serialize and deserialize the messages in the language of your choice.
For example, for the schema above, the metaclass in Java would be:

```java
package com.example;

import org.apache.avro.Schema;
import org.apache.avro.specific.SpecificRecordBase;
import org.apache.avro.specific.SpecificData;


public class Person extends SpecificRecordBase {
    public static final Schema SCHEMA$ = new Schema.Parser().parse("{\"type\":\"record\",\"name\":\"Person\",\"namespace\":\"com.example\",\"fields\":[{\"name\":\"name\",\"type\":\"string\"},{\"name\":\"age\",\"type\":\"string\"}]}");

    public static Schema getClassSchema() {
        return SCHEMA$;
    }

    private String name;
    private String age;

    public Person() {
    }

    public Person(String name, String age) {
        this.name = name;
        this.age = age;
    }

    @Override
    public Schema getSchema() {
        return SCHEMA$;
    }

    @Override
    public Object get(int field$) {
        switch (field$) {
            case 0:
                return name;
            case 1:
                return age;
            default:
                throw new org.apache.avro.AvroRuntimeException("Bad index");
        }
    }

    @Override
    public void put(int field$, Object value$) {
        switch (field$) {
            case 0:
                name = value$ != null ? value$.toString() : null;
                break;
            case 1:
                age = value$ != null ? value$.toString() : null;
                break;
            default:
                throw new org.apache.avro.AvroRuntimeException("Bad index");
        }
    }

    public String getName() {
        return name;
    }

    public void setName(String value) {
        this.name = value;
    }

    public String getAge() {
        return age;
    }

    public void setAge(String value) {
        this.age = value;
    }
}
```

and the metaclass in Python would be:

```python
from typing import Dict, Any, Union, TypeVar, Type, cast
import typing
import json
import avro.schema
import avro.io


class Person(object):
    """
    Autogenerated by Avro
    """
    _AVRO_SCHEMA = avro.schema.Parse(json.dumps({
        "type": "record",
        "name": "Person",
        "namespace": "com.example",
        "fields": [
            {
                "name": "name",
                "type": "string"
            },
            {
                "name": "age",
                "type": "string"
            }
        ]
    }))
    _AVRO_CODEC = avro.io.BinaryDecoder

    def __init__(self, name: str=None, age: str=None) -> None:
        self.name = name
        self.age = age

    def __repr__(self) -> str:
        return str(self.to_dict())

    def to_dict(self) -> Dict[str, Any]:
        return {
            "name": self.name,
            "age": self.age
        }

    @staticmethod
    def from_dict(d: Dict[str, Any]) -> 'Person':
        return Person(
            name=d.get('name', None),
            age=d.get('age', None)
        )

    @staticmethod
    def deserialize(data: Union[bytes, bytearray, memoryview], codec: Type[_AVRO_CODEC]=_AVRO_CODEC) -> 'Person':
        reader = avro.io.DatumReader(Person._AVRO_SCHEMA)
        decoder = codec(reader, reader)
        return cast(Person, reader.read(Person._AVRO_SCHEMA, decoder))

    def serialize(self, codec: Type[_AVRO_CODEC]=_AVRO_CODEC) -> bytes:
        writer = avro.io.DatumWriter(Person._AVRO_SCHEMA)
        buffer = io.BytesIO()
        encoder = codec(writer)
        writer.write(self.to_dict(), encoder)
        return buffer.getvalue()
```

These metaclasses allow you to initialize and access the fields of the message in a type-safe way.
They can also be used to easily serialize and deserialize the messages.
For example in the Java example above, the message can be serialized like this:

```java
import com.example.Person;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.clients.producer.RecordMetadata;

import java.util.Properties;
import java.util.concurrent.ExecutionException;


public class ProducerDemo {
    public static void main(String[] args) throws ExecutionException, InterruptedException {
        // Create Producer Properties
        Properties properties = new Properties();
        properties.setProperty("bootstrap.servers", "localhost:9092");
        properties.setProperty("key.serializer", org.apache.kafka.common.serialization.StringSerializer.class);
        properties.setProperty("value.serializer", io.confluent.kafka.serializers.KafkaAvroSerializer.class);
        properties.setProperty("schema.registry.url", "http://localhost:8081"); // Note that we now need to specify the address of the Schema Registry
        properties.setProperty("topic.name", "people")

        // Create the Producer
        KafkaProducer<String, Person> producer = new KafkaProducer<>(properties);

        // Create a Producer Record
        Person person = new Person("John", "25");
        ProducerRecord<String, Person> record = new ProducerRecord<>(properties.getProperty("topic.name"), person);

        // Send Data - Asynchronous
        producer.send(record, (RecordMetadata recordMetadata, Exception e) -> {
            if (e == null) {
                System.out.println("Received new metadata. \n" +
                        "Topic: " + recordMetadata.topic() + "\n" +
                        "Partition: " + recordMetadata.partition() + "\n" +
                        "Offset: " + recordMetadata.offset() + "\n" +
                        "Timestamp: " + recordMetadata.timestamp());
            } else {
                System.out.println("Error while producing: " + e);
            }
        }).get(); // block the .send() to make it synchronous - don't do this in production!

        // Flush Data
        producer.flush();

        // Flush and Close Producer
        producer.close();
    }
}
```


### Other Useful Tools

- REST Proxy - It is a service that is used to manage the Kafka cluster using a REST API. It is usually deployed as a docker container and usually on the same machine as the Kafka cluster. It is also usually deployed with the Schema Registry (see [this](#schema-registry)).
- KSQL - It is a streaming SQL engine that is used to query the Kafka cluster using SQL queries. It allows you to create streams and tables from topics, join streams and tables, filter streams and tables, etc. (see also [this](./ksqldb.md))
- Kafka Connect - It is a service that is used to connect the Kafka cluster with other systems. It allows you to create connectors that can be used to read data from other systems and write them to Kafka topics or read data from Kafka topics and write them to other systems. It also allows you to create transformations that can be used to transform the data before writing them to Kafka topics or after reading them from Kafka topics.
- Control Center - It is a service that is used to monitor the Kafka cluster. It allows you to monitor the topics, the producers, the consumers, the brokers, etc. It also allows you to create alerts for when something goes wrong with the Kafka cluster.

> Note: The REST Proxy, KSQL, Kafka Connect, and Control Center are all part of the Confluent Platform. 
> They are not part of the Apache Kafka project, but they are open-source and free to use.
> BUT since they are part of the Confluent Platform, some of them are not free for enterprise use (eg Control Center)


## Noteworthy Configurations

### Auto Create Topics and Schemas

The Kafka cluster can be configured to not automatically create topics and schemas when a producer or consumer tries to send or consume messages from a topic or a schema that does not exist.
This is useful in production because it prevents the creation of topics and schemas that are not needed or are caused by an error.


### Testing the Producer

When testing the producer, it is useful to instantiate a Consumer to the same topic and consume the messages that the producer sends.
But the tricky part is that the consumer must be instantiated before the producer sends the messages and that the consumer must only consume the messages that where sent by the producer in the current run of the test.
This can be achieved by setting the `auto.offset.reset` property of the consumer to `latest` and by setting the `enable.auto.commit` property of the consumer to `false` or by creating a new consumer group for each test run (this is not recommended because it can cause problems in production).

### Testing `auto.register.schemas=false` or `auto.create.topics.enable=false`

When testing these configurations, it is useful to create a REST client that can be used to create or delete topics and schemas before or after each test, because as far as I know, there is no way to create or delete topics and schemas from the Kafka API if these configurations are set to false.

## Resources

#### E-Books

- [Kafka: The Definitive Guide (Requires Email Confirmation)]
- [Kafka: The Definitive Guide (PDF version but old)]

#### Documentation

- [Apache Kafka Quick Start]

#### Videos

- [Apache Kafka Tutorials | Kafka 101]
- [Schema Registry 101 | Introduction to Schema Registry]
- [Apache Kafka for Beginners]
- [Apache Kafka and KSQL in Action]


<!-- Links -->
[Kafka: The Definitive Guide (Requires Email Confirmation)]: https://www.confluent.io/resources/kafka-the-definitive-guide/
[Kafka: The Definitive Guide (PDF version but old)]: https://www.confluent.io/wp-content/uploads/confluent-kafka-definitive-guide-complete.pdf
[Apache Kafka Tutorials | Kafka 101]: https://www.youtube.com/playlist?list=PLa7VYi0yPIH0KbnJQcMv5N9iW8HkZHztH
[Schema Registry 101 | Introduction to Schema Registry]: https://www.youtube.com/playlist?list=PLa7VYi0yPIH1KE10jwqmFEM61krd9WXQV
[Apache Kafka for Beginners]: https://www.youtube.com/playlist?list=PLt1SIbA8guusxiHz9bveV-UHs_biWFegU
[Apache Kafka and KSQL in Action]: https://www.youtube.com/watch?v=Z8_O0wEIafw
[Apache Kafka Quick Start]: https://developer.confluent.io/quickstart/kafka-docker/
[Getting Started with Apache Kafka and Confluent REST Proxy]: https://developer.confluent.io/get-started/rest/
[Quick Start for Confluent Platform]: https://docs.confluent.io/platform/current/platform-quickstart.html
[kafka-python]: https://kafka-python.readthedocs.io/en/master/index.html