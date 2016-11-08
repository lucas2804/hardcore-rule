##Getting Started

1 - After install PostgreSQL we've already had: "postgres" database and username
2 - Create role: `CREATING ROLE mydb_admin LOGIN PASSWORD '1234qwer'; `

3 - Create DB and set owner: `CREATE DATABASE mydb WITH owner = mydb_admin;`

###Grant

- **GRANT some_privilege TO some_role;**

- 1) Grant what you have.
- 2) **DROP and ALTER** never be granted away

- 3) **Owner** have full privileges
- 4) **WITH GRANT OPTION**: grantee can grant onwards, on the future.

`GRANT ALL ON ALL TABLES IN SCHEMA public  TO mydb_admin WITH GRANT OPTION;`
