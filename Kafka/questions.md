# My Kafka Questions

## Questions

### A. **Brokers**

- I. General  
  1. If so, can they serve all the partitions of each topic? (I think so)

- II. Clustering
  1. What is the difference between a node and a broker? Can multiple brokers be on the same node or the opposite?

### B. **Schema Registry**

- I. General
  1. How do you programmatically connect to the Schema Registry in Java? (I think you need to use the `KafkaAvroSerializer` and `KafkaAvroDeserializer` classes)

- II. Schema Evolution
  1. How do you change the schema over time?
      1. Do the old messages get updated? 
      2. Do you need to create a new topic?

### C. **Kafka Connect**

- I. General
    1. Can we gain anything by using it instead of just using the Producer and Consumer APIs?


### D. **Zookeeper**

- I. General
    1. What is Zookeeper?

## Answers

