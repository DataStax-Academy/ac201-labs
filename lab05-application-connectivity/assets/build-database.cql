CREATE KEYSPACE world WITH replication = {
  'class':'NetworkTopologyStrategy',
  'datacenter1':1
};

use world;

CREATE TABLE countries (
  id int PRIMARY KEY,
  continent text,
  country text
);

INSERT INTO countries (id, continent, country) VALUES (1, 'Africa', 'Nigeria');
INSERT INTO countries (id, continent, country) VALUES (2, 'Africa', 'South Africa');
INSERT INTO countries (id, continent, country) VALUES (3, 'Asia', 'China');
INSERT INTO countries (id, continent, country) VALUES (4, 'Asia', 'India');
INSERT INTO countries (id, continent, country) VALUES (5, 'Europe', 'Germany');
INSERT INTO countries (id, continent, country) VALUES (6, 'Europe', 'France');
INSERT INTO countries (id, continent, country) VALUES (7, 'North America', 'United States');
INSERT INTO countries (id, continent, country) VALUES (8, 'North America', 'Canada');
INSERT INTO countries (id, continent, country) VALUES (9, 'South America', 'Brazil');
INSERT INTO countries (id, continent, country) VALUES (10, 'South America', 'Argentina');