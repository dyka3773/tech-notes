<!-- omit in toc -->
# Oracle DBMS

<!-- omit in toc -->
## Table of Contents
- [Schemas and Users](#schemas-and-users)
- [DBMS Metadata Views](#dbms-metadata-views)
- [Invisible Columns](#invisible-columns)
- [TRANSACTION\_ID](#transaction_id)
- [Synonyms](#synonyms)

## Schemas and Users

In Oracle, a schema has a one-to-one relationship with a user. A schema is a collection of database objects (tables, views, indexes, etc.) and a user is a database account that can connect to the database.


## DBMS Metadata Views

All the tables that contain information about the database are created by Oracle and their names start with `DBA_`, `ALL_` or `USER_`. 

- `DBA_` views contain all the information about the database and are accessible to users with the `DBA` role.
- `ALL_` views contain all the information about the database that the current user has access to.
- `USER_` views contain all the information about the database that the current user owns.

## Invisible Columns

Invisible columns are columns that are not visible to the user or any other process that uses the table unless they explicitly ask for them. They are used to hide columns that are used internally by the database. They are created using the `INVISIBLE` keyword in the `CREATE TABLE` statement.

```sql
CREATE TABLE table_name (
    column1 datatype INVISIBLE,
    column2 datatype,
    column3 datatype INVISIBLE
);
```

```sql
-- The above CREATE TABLE statement when queried using the following statement:
SELECT * FROM table_name;
-- will return only column2

-- To query the invisible columns, we need to explicitly ask for them:
SELECT column1, column2, column3 FROM table_name;
```

## TRANSACTION_ID 

You can get the `TRANSACTION_ID` of a transaction using the `DBMS_TRANSACTION.LOCAL_TRANSACTION_ID` function.

```sql
SET SERVEROUTPUT ON
DECLARE
    l_transaction_id VARCHAR2(64);
BEGIN
    l_transaction_id := DBMS_TRANSACTION.LOCAL_TRANSACTION_ID;
    DBMS_OUTPUT.PUT_LINE(l_transaction_id);
END;
```

This is extremely useful when used in conjunction with the [Invisible Columns](#invisible-columns) feature to track the changes made by a transaction to a table.

## Synonyms

A synonym is an alias for a table, view, sequence, or program unit.
It is used to provide an alternative name for an object or a level of encapsulation for an object.
    
```sql
CREATE SYNONYM synonym_name FOR object_name;
```

> WARNING: Synonyms still exist even if the object they point to is dropped.
> This can lead to errors when querying the synonym.
> To check if a synonym is pointing to a non-existent table, use the following query:
> 
> ```sql
> SELECT *
> FROM ALL_SYNONYMS
> WHERE TABLE_NAME NOT IN (
>     SELECT DISTINCT TABLE_NAME
>     FROM ALL_TABLES
> );
> ```
