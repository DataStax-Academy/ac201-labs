from cassandra.cluster import Cluster

# Connect to the Cassandra cluster use the keyspace 'cars'
cluster = Cluster(['172.30.1.10']) 
session = cluster.connect()
session.set_keyspace('world') 

# Query the inventory table
query = "SELECT id, continent, country FROM countries"
rows = session.execute(query)

# Display the results
print("Countries:")
for row in rows:
    print(f"ID: {row.id:<4} Continent: {row.continent:<15} Country: {row.country}")

# Close the connection
cluster.shutdown()
