<!-- omit from toc -->
# Apache Kafka

<!-- omit from toc -->
## Table of Contents
- [Introduction](#introduction)
- [Architecture](#architecture)
- [Buzzwords](#buzzwords)
  - [Topics](#topics)
  - [Partitions](#partitions)
  - [Brokers](#brokers)
  - [Producers](#producers)
  - [Consumers](#consumers)
  - [Consumer Groups](#consumer-groups)
  - [Kafka Cluster Controller](#kafka-cluster-controller)
  - [Zookeeper](#zookeeper)
- [Eco-System](#eco-system)
  - [Kafka Connect](#kafka-connect)
  - [Kafka Streams](#kafka-streams)
  - [KSQLDB](#ksqldb)
  - [Kafka REST Proxy](#kafka-rest-proxy)
  - [Schema Registry](#schema-registry)
- [Resources](#resources)
    - [E-Books](#e-books)
    - [Documentation](#documentation)
    - [Videos](#videos)


## Introduction

Apache Kafka is a distributed event streaming platform. It is used for building real-time data pipelines and streaming apps. It is horizontally scalable and fault-tolerant.

## Architecture

To the Kafka process, everything is either a Producer, a Consumer or a Broker.
The Producer and Consumer are clients of the Kafka process.
The Broker is a part of the Kafka process itself.
The Producer and Consumer can be written in any language (almost).
The Broker is written in Java.

## Buzzwords

### Topics

- A Topic is a particular stream of data. It is similar to a table in a database.
- Data can be duplicated between Topics (eg Vessels and FilteredVesselsByCountry).
- It is essentially a category or feed name to which records are published.
- Topics are append-only, meaning that records are added to the end of them and never modified or deleted.
- Topics are not indexed, so you can only search for messages by their offset.

### Partitions

- Topics are split into partitions to allow for parallel processing.
- Each partition is ordered and immutable.
- Each message in a partition is assigned a sequential ID number called the offset that uniquely identifies each message within the partition.
- Messages are retained for a configurable amount of time (default is 7 days).

### Brokers

- A computer, instance, or container running Kafka.
- A Kafka cluster is composed of multiple brokers.
- Each broker is identified by its ID (integer).
- Each broker contains and manages certain topic partitions.
- After connecting to any broker (called a bootstrap broker), you will be connected to the entire cluster.
- Brokers are stateless, so they use Zookeeper for maintaining their cluster state.
- Brokers are responsible for:
  - Receiving messages from producers and appending them to a commit log.
  - Responding to fetch requests from consumers and returning messages that have been committed to the log.
  - Notifying producers and consumers of errors.
  - Replicating partitions across a configurable number of nodes for fault tolerance.

### Producers

- Producers are processes that publish data (push messages) to topics. 
- They can choose to receive acknowledgements of data writes.
- They choose which topic or topics to publish to, which broker to send the data to and which partition to write to within the topic.
- They can choose to send a key with the message. If a key is sent, then all messages with the same key will go to the same partition. If no key is sent, then the partition is chosen in a round-robin fashion.

### Consumers

- Consumers read data (pull messages) from a topic.
- They subscribe to one or more topics and read the messages in the order in which they were published to the partition.
- They keep track of which messages they have consumed by keeping track of the offset of messages.

### Consumer Groups

- Consumer groups are groups of consumer processes that are subscribed to a list of topics.
- Each consumer within a group reads from a unique partition and the same message is not read by multiple consumers in the same group. If there are more consumers than partitions, some consumers will be inactive. This is used to scale consumption of topics.
- If you want to read all the messages of a topic in parallel, you need to have as many consumers as there are partitions.

### Kafka Cluster Controller

- The Kafka cluster controller is responsible for administrative operations of the cluster.
- It is responsible for :
  - Electing a leader for each partition.
  - Balancing leadership of partitions across the nodes in a cluster.
  - Detecting broker failures and performing leadership re-elections.
  - Performing partition reassignments as brokers join and leave the cluster.

### Zookeeper

- Zookeeper is a distributed, open-source configuration, synchronization, and naming registry for large distributed systems.
- It is used to coordinate the brokers/cluster.
- It is used to elect a controller.
- It is used to send notifications to Kafka in case of changes (eg new topic, broker dies, broker comes back up, etc).
- It is used to store metadata about the cluster (eg topics, brokers, etc).
- It has an internal hierarchy of nodes, similar to a file system.
- Each node is called a znode.
- Each znode can be persistent or ephemeral.
- Each znode can store data.
- No two znodes can have the same name.
- Each znode can be watched for changes.


## Eco-System

Kafka comes with some tools that make it easier to use and integrate with other systems for some common use cases. Some of these tools are:

### Kafka Connect

- Kafka Connect is a tool for scalably and reliably streaming data between Apache Kafka and other data systems.
- It makes it simple to quickly define connectors that move large collections of data into and out of Kafka. The connectors can either be **source** connectors that import data into Kafka or **sink** connectors that export data out of Kafka. There are a lot of connectors available for use and you can also write your own.
- It can ingest entire databases or collect metrics from all your application servers into Kafka topics, making the data available for stream processing with low latency.
- It can also deliver data from Kafka topics into secondary indexes like Elasticsearch or into batch systems such as Hadoop for offline analysis.

### Kafka Streams

- Kafka Streams is a client library for building applications and microservices, where the input and output data are stored in Kafka clusters.
- It allows you to build applications that process and analyze data stored in Kafka topics. It allows you to join, aggregate, and transform data from multiple topics using stateless and stateful operations. And it lets you create new Kafka topics from streams of data.

### KSQLDB

- KSQLDB is the streaming SQL engine for Apache Kafka built on top of Kafka Streams. It provides an easy-to-use, yet powerful interactive SQL interface for stream processing on Kafka, without the need to write code in a programming language such as Java or Python. 
- It supports a wide range of powerful stream processing operations including aggregations, joins, windowing, sessionization, and much more. 
- It supports both reading from and writing into Kafka topics, and integrates seamlessly with Kafka's exactly-once semantics.
- **A KSQL Stream is a Topic with a Schema.**

For a quick reference on KSQLDB, check out the [KSQLDB](./ksqldb.md) file.

### Kafka REST Proxy

- The Kafka REST Proxy provides a RESTful interface to a Kafka cluster, making it easy to produce and consume messages, view the state of the cluster, and perform administrative actions without using the native Kafka protocol or clients.
- It is built on top of the Kafka protocol, but it is not part of Apache Kafka itself.
- It is a good fit for scenarios where you want to integrate Kafka with existing systems that already have a REST API.

### Schema Registry

- The Schema Registry provides serializers that plug into Kafka clients that handle the data schema for Kafka messages that are sent in the Avro format.
- It stores a versioned history of all schemas based on a specified subject name strategy.
- It allows the evolution of schemas according to the configured compatibility settings and expanded Avro support.

Read more about it on the [Schema Registry](./schema-registry.md) file.


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