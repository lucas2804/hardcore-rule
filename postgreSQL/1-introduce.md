##Connecting to the PostgreSQL server

### I - Some Parameters
- Specify the following parameters:
1) **Host**             : is run
2) **Port**             : is listening
3) **Database name**    : must exist
4) **Username**         : must exist
5) **Password**         : must pass authentication method which server specified, password or SSH...

- Implicitly specify params from environments
1) PGHOST or PGHOSTADDR
2) PGPORT
3) PGDATABASE
4) PGUSER
5) PGPASSWORD

### II - How it works
 
- PostgreSQL is a client-server database:
    1) Postgres run as a server
    2) And can access server remotely through the network

- A **database server** known as **database cluster**: contain different database name(blurb_development, blurb_production...)

### III - Connect

```
psql -h localhost -d postgres -p 5432 -U postgres

SELECT current_user, current_database(), inet_server_addr(), inet_server_port();

\conninfo
```

### IV - File Locations

#### SELECT * FROM pg_settings WHERE category = 'File Locations'; 

- **cd /Users/luc/Library/Application\ Support/Postgres/var-9.6**

- **postgresql.conf**: Controles general settings such as memory allocation, default storage location for new databases, IP addresses, logs...

- **pg_hba.conf**: Controls security, which users can log in which databases, which IP addresses or which authentication schema to expect.

- **pg_ident.conf**: maps an authenticated OS login to a PostgreSQL user. as root to super user... 

```
SELECT name, context, unit, setting boot_val, reset_val
FROM pg_settings
WHERE name IN ('listen_addresses', 'max_connections', 'shared_buffers', 'effective_cache_size', 'work_mem', 'maintenance_work_mem')
ORDER BY context, name;
```


#### pg_hba.conf as .htaccess
```
pg_hba.conf
# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     ident
# IPv4 local connections:
host    all             all             127.0.0.1/32            trust
# IPv6 local connections:
host    all             all             ::1/128                 md5
hostssl all             all             192.168.54.0/24         md5
# Allow replication connections from localhost, by a user with the
# replication privilege.
#local   replication     postgres                                trust

```

- For each connection request, PostgreSQL check **pg_hba.conf** from top to boty

####Authentication methods
- **trust**     : allow all connections
- **md5**       : have to pass md5 hash as "asdasd123asdzxcse12..."
- **password**  : clear-text password
- **ident**     : use pg_ident.conf, map OS account to PostgreSQL account, No password is checked.
- **peer**      : use client's OS name, useful for local connections.

- Apply the changes of configurations: `SELECT pg_reload_conf()`
- Retrieve a listing of recent connections and PIDs: `SELECT * FROM pg_stat_activity;`
- Kill the connection: `SELECT pg_terminate_backend(5385)`
- Kill all the connections belongs to a role: ` SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE username = 'some_role' `

###Roles

- PostgreSQL represents users as roles.
- Roles contain other roles call **group roles**

```
CREATE ROLE luc LOGIN PASSWORD '1234qwer' CREATEDB VALID UNTIL 'infinity';
SELECT * FROM pg_roles
```

- **infinity**: which means the role never expires.

###Group Roles

- Group Roles have no login rights but serve as a container. This is a best practice.

```
CREATE ROLE royalty INHERIT
GRANT royalty TO luc
GRANT royalty TO lucluc

CREATE DATABASE luc_db TEMPLATE

# Group databases in to my_extensions group
1 - CREATE SCHEMA my_extensions
2 - enable $user in postgresql.conf
search_path = '"$user", public'	# schema names

3 - ALTER DATABASE mydb SET search_path='"$user", public, my_extensions';

```


    
    




