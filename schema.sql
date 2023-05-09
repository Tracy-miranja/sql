/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
  id int PRIMARY KEY,
  name VARCHAR(255) NOT null,
  date_of_birth DATE NOT null,
  escape_attempts int null,
  neutered  boolean null,
  neutered_weight_kg decimal NOT null
);

