<!-- omit in toc -->
# Useful Oracle Metadata Queries

<!-- omit in toc -->
## Table of Contents

- [All the Metadata Tables and What They Do](#all-the-metadata-tables-and-what-they-do)
- [All The Tables Created by Oracle That Contain Information About the Database](#all-the-tables-created-by-oracle-that-contain-information-about-the-database)
- [All The Users Not Maintained By Oracle](#all-the-users-not-maintained-by-oracle)
- [All The Indices of The Current User](#all-the-indices-of-the-current-user)
- [Synonyms of Tables that The User Has Access To](#synonyms-of-tables-that-the-user-has-access-to)
- [Sequences that Belong to The Current User](#sequences-that-belong-to-the-current-user)
- [Documentation of All Columns of Tables of The Current User](#documentation-of-all-columns-of-tables-of-the-current-user)


## All the Metadata Tables and What They Do

```sql
SELECT *
FROM dba_tab_comments
WHERE table_name LIKE 'DBA_%'
AND owner in (
    SELECT DISTINCT username
    FROM dba_users
    WHERE oracle_maintained = 'Y'
)
ORDER BY table_name;
```

## All The Tables Created by Oracle That Contain Information About the Database

```sql
SELECT DISTINCT table_name, comments
FROM dba_tab_comments
WHERE (table_name LIKE 'DBA_%' OR table_name LIKE 'ALL_%' OR table_name LIKE 'USER_%')
AND (table_name NOT LIKE '%$%')
AND owner in (
    SELECT DISTINCT username
    FROM dba_users
    WHERE oracle_maintained = 'Y'
)
ORDER BY table_name;
```

## All The Users Not Maintained By Oracle

```sql
SELECT DISTINCT username, ORACLE_MAINTAINED 
FROM dba_users 
WHERE ORACLE_MAINTAINED='N';
```
> **Note:** This query only works on Oracle 12c and above

> *Source:* [How to get all the users not maintained by Oracle][1]


## All The Indices of The Current User

```sql
-- This query does not return the columns of the indices
SELECT *
FROM user_indexes
WHERE index_name NOT LIKE '%$%';
```

```sql
-- This query returns the columns of the indices
SELECT ind.index_name,
       ind_col.column_name,
       ind.index_type,
       ind.uniqueness,
       ind.table_owner as schema_name,
       ind.table_name as object_name,
       ind.table_type as object_type       
FROM user_indexes ind
    INNER JOIN user_ind_columns ind_col 
    ON (ind.index_name = ind_col.index_name)
where ind.index_name NOT LIKE '%$%'
ORDER BY ind.table_name,
        ind.index_name,
        ind_col.column_position;
```
> *Source:* [Oracle SQL*Plus: The Definitive Guide, 2nd Edition by Jonathan Gennick][2] and [List all indexes in Oracle database][3]


## Synonyms of Tables that The User Has Access To

```sql
SELECT *
FROM ALL_SYNONYMS;
```
> **Note:** `TABLE_OWNER` and `TABLE_NAME` columns are the owner of the table and the name of the table that the synonym points to and `SYNONYM_NAME` is the name of the synonym. `OWNER` column is the owner of the synonym.

> **Note 2:** A useful query that derives from the above is to find synonyms that point to tables that do not exist in the database (eg tables that have been dropped but the synonym has not been removed).
> This can be done by using the following query:
> 
> ```sql
> SELECT *
> FROM ALL_SYNONYMS
> WHERE TABLE_NAME NOT IN (
>     SELECT DISTINCT TABLE_NAME
>     FROM ALL_TABLES
> );
> ```

## Sequences that Belong to The Current User

```sql
SELECT *
FROM USER_SEQUENCES;
```

## Documentation of All Columns of Tables of The Current User

```sql
SELECT table_name, column_name, comments, owner
FROM user_col_comments
WHERE table_name NOT IN (
    SELECT user_tab_comments.table_name
    FROM user_tab_comments
    WHERE user_tab_comments.table_type = 'VIEW'
)
AND table_name NOT LIKE '%$%'
```


<!-- Resources -->
[1]: https://stackoverflow.com/questions/4833459/oracle-sql-query-for-listing-all-schemas-in-a-db
[2]: https://www.oreilly.com/library/view/oracle-sqlplus-the/0596007469/ch10s05.html
[3]: https://dataedo.com/kb/query/oracle/list-all-indexes-in-the-database