<!-- omit from toc -->
# KSQLDB

<!-- omit from toc -->
## Table of Contents
- [Introduction](#introduction)
  - [Streams](#streams)
    - [Creating Streams](#creating-streams)
  - [Tables](#tables)
  - [Queries in KSQLDB](#queries-in-ksqldb)
- [Basic KSQL Commands](#basic-ksql-commands)

## Introduction

### Streams

A stream is a topic with a schema. 
Either the schema is inferred from the data and the Schema Registry or it is explicitly defined by the user. 
Basically, Streams is the feature that makes KSQLDB different from other DBMS. 
They are responsible for where the data is coming from and where it is going to.

#### Creating Streams

When creating a stream either a corresponding topic is created or an existing topic is used.

To create a stream, use the following syntax:

```sql
-- Create a stream by filtering an existing stream
CREATE STREAM <stream_name> AS SELECT * FROM <stream_name> WHERE <condition>;

-- or create a stream from a corresponding topic
CREATE STREAM <stream_name> WITH (KAFKA_TOPIC='<topic_name>', VALUE_FORMAT='<format>');
```

### Tables

Tables in KSQLDB are similar to tables in SQL. 
They are a collection of rows and columns with a schema, a primary key and possibly other constraints. 

Now if you are familiar with SQL, you might ask yourself, **why do we need tables in KSQLDB, when we already have streams?** 
The answer is, that a table is a stream with a primary key so for each key, there is only one value, the latest value. 
A stream on the other hand can have multiple values for the same key as it is basically a log of all values and value changes. 

If the table is created from a stream and the stream is updated, the table is updated as well. 
The data is still updated in real-time like the stream, but if you query the table for a specific key, you will only get the latest value for that key each time it gets updated.

<!-- FIXME: The above line needs to be rephrased -->

<!-- TODO: Add a HOWTO create a Table -->

### Queries in KSQLDB

Queries in KSQLDB are similar to SQL queries.
When applying a query to a stream, the result is a new stream.
When applying a query to a table, the result is a new table.

When querying a stream, the result is a stream, because the stream is continuously updated.


## Basic KSQL Commands

```sql
-- list topics
SHOW TOPICS;
```

```sql
-- list streams
SHOW STREAMS;
```

```sql
-- Show the contents of a topic
PRINT '<topic_name>';
```

```sql
-- Show the schema of a stream
DESCRIBE '<stream_name>';

-- for runtime statistics and query details
DESCRIBE EXTENDED '<stream_name>';
```