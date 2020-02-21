cqlsh cassandra --execute="CREATE KEYSPACE IF NOT EXISTS $CASSANDRA_NETWORK_KEYSPACE WITH replication = {'class': 'SimpleStrategy', 'replication_factor' : 1};"
