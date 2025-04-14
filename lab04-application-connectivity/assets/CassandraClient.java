package com.example;

import com.datastax.oss.driver.api.core.CqlSession;
import com.datastax.oss.driver.api.core.cql.ResultSet;
import com.datastax.oss.driver.api.core.cql.Row;

import java.net.InetSocketAddress;

public class CassandraClient {
  public static void main(String[] args) {

    // Connect to the Cassandra cluster
    try (CqlSession session = CqlSession.builder()
                               .addContactPoint(new InetSocketAddress("172.30.1.10", 9042))
                               .withKeyspace("world")
                               .withLocalDatacenter("datacenter1")
                               .build()) {
  
      String query = "SELECT id, continent, country FROM countries";

      // Execute the query
      ResultSet resultSet = session.execute(query);

      System.out.println("\n\nCountries:");
      for (Row row : resultSet) {
        int id = row.getInt("id");
        String contient = row.getString("continent");
        String country = row.getString("country");

        System.out.printf("ID: %-4d Continent: %-15s Country: %s%n", id, contient, country);
      }
      
      System.out.println();

    } catch (Exception e) { e.printStackTrace(); }
  }
}
