##PSQL when you have no choice

- AUTOCOMMMIT is enabled on each query so it's not safe.

```
\set AUTOCOMMIT off
UPDATE ...
ROLLBACK ...
COMMIT ...
```

- List tables: **\dt+ pg_catalog.pg_t**
```
   Schema   |       Name       | Type  |  Owner   |    Size    | Description 
------------+------------------+-------+----------+------------+-------------
 pg_catalog | pg_tablespace    | table | postgres | 40 kB      | 
 pg_catalog | pg_transform     | table | postgres | 0 bytes    | 
```

- List columns: **\d+ pg_transform**
```
                     Table "pg_catalog.pg_transform"
   Column   |  Type   | Modifiers | Storage | Stats target | Description 
------------+---------+-----------+---------+--------------+-------------
 trftype    | oid     | not null  | plain   |              | 
 trflang    | oid     | not null  | plain   |              | 
```

###Non-interactively

