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

ALTER TABLE animals ADD COLUMN animal_id SERIAL PRIMARY KEY;
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INTEGER REFERENCES species(id);

CREATE TABLE vets (
    id INT SERIAL PRIMARY KEY
    name VARCHAR NOT NULL
    age integer NOT NULL
    date_of_graduation date NOT NULL
)

CREATE TABLE specializations (
  vets_id INTEGER NOT NULL,
  species_id INTEGER NOT NULL,
  PRIMARY KEY (vet_id, species_id),
  FOREIGN KEY (vet_id) REFERENCES vets (id),
  FOREIGN KEY (species_id) REFERENCES species (id)
);

CREATE TABLE visits (
  animal_id INTEGER NOT NULL,
  vet_id INTEGER NOT NULL,
  visit_date DATE NOT NULL,
  PRIMARY KEY (animal_id, vet_id, visit_date),
  FOREIGN KEY (animal_id) REFERENCES animals(animal_id),
  FOREIGN KEY (vet_id) REFERENCES vets(id)
);




