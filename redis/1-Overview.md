### Redis Fetured

- 1) Insertion of data sets: very fast in key-value and NO EXCEPTION
- 2) Random reads: All key-value are stored in memory -> memory requirements very high. So Redis use **virtual memory**.
- 21) **Virtual memory** will keep all the keys in the memory but will write the lease recently-used values to disk.

- 3) Fault tolerance: Redis uses the master-slave topology. All the data in the master in asynchronously copied to the slave. If master is down, one of the slave nodes can be promoted to master.
 
- 4) Eventual consistency: Master to write data and slaves to read-only for clients. So somethime the data in slave nodes will be old, lag...

- 5) Load balancing: The clients should have the logic for read-request(send to slaves) and write-request(send to master) Or can use third-party proxies.

- 6) Sharding: break index into multiple shards. When get data, Redis will across multiple shards and collect last result. (Ez to horizontal scalable)

- 7) Multi-data center support: