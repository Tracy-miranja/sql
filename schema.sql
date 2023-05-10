CREATE TABLE animals (
  id int PRIMARY KEY,
  name VARCHAR(255) NOT null,
  date_of_birth DATE NOT null,
  escape_attempts int null,
  neutered  boolean null,
  neutered_weight_kg decimal NOT null,
  species VARCHAR(255)
);

ALTER TABLE animals ADD COLUMN species VARCHAR(255);

CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(255),
  age INTEGER
);

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);
