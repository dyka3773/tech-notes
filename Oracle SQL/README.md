<!-- omit in toc -->
# Oracle DBMS

<!-- omit in toc -->
## Table of Contents


## Schemas and Users

In Oracle, a schema has a one-to-one relationship with a user. A schema is a collection of database objects (tables, views, indexes, etc.) and a user is a database account that can connect to the database.


## DBMS Metadata Views

All the tables that contain information about the database are created by Oracle and their names start with `DBA_`, `ALL_` or `USER_`. 

- `DBA_` views contain all the information about the database and are accessible to users with the `DBA` role.
- `ALL_` views contain all the information about the database that the current user has access to.
- `USER_` views contain all the information about the database that the current user owns.