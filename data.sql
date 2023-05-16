INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, neutered_weight_kg ) VALUES (1,'Agumon','2020-02-03',0, 'true', 10.23);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, neutered_weight_kg) VALUES (2,'Gabumon','2018-11-15',2, 'true', 8);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, neutered_weight_kg) VALUES (3,' Pikachu','2021-01-07',1, 'false', 15.04,);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, neutered_weight_kg) VALUES (5,'Devimon','2017-05-12',5, 'true', 11);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, neutered_weight_kg) VALUES (6,'Charmander','2020-02-08',0, 'false', 8);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, neutered_weight_kg) VALUES (7,' Plantmon','2021-11-15',2, 'true', 5.7);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, neutered_weight_kg) VALUES (8,'Squirtle','1993-04-02',3, 'false', 12.13);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, neutered_weight_kg) VALUES (9,'Angemon','2003-06-12',1, 'true', 45);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, neutered_weight_kg) VALUES (10,'Boarmon','2005-06-07',7, 'true', 20.40);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, neutered_weight_kg) VALUES (11,'Blossom','1998-10-13',3, 'true', 17);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, neutered_weight_kg) VALUES (12,'Ditto','2022-05-14',4, 'true', 22);
INSERT INTO owners (full_name, age)
VALUES
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

INSERT INTO species (name) VALUES
('Pokemon'),
('Digimon');

UPDATE animals 
SET species_id = 
  CASE 
    WHEN name ILIKE '%mon' THEN Digimon
    ELSE Pokemon 
  END;
  
UPDATE animals SET species_id = CASE  
   WHEN name ILIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon') 
   ELSE (SELECT id FROM species WHERE name = 'Pokemon') END WHERE species_id IS NULL;

UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name IN ('Angemon', 'Boarmon');

INSERT INTO vets (name, age, date_of_graduation) VALUES
  ('William Tatcher', 45, '2000-04-23'),
  ('Maisy Smith', 26, '2019-01-17'),
  ('Stephanie Mendez', 64, '1981-05-04'),
  ('Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations (vet_id, species_id) VALUES
  ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM species WHERE name = 'Pokemon')),
  ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Digimon')),
  ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Pokemon')),
  ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM species WHERE name = 'Digimon'));

INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (1, 2, '2020-07-22');

INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES
(2, 4, '2021-02-02'),
(3, 2, '2020-01-05'),
(3, 2, '2020-03-08');

INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES
(3, 2, '2020-05-14'),
(4, 3, '2021-05-04'),
(5, 4, '2021-02-24');

INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES
(6, 2, '2019-12-21'),
(6, 1, '2020-08-10'),
(6, 2, '2021-04-07');

INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES
(3, 3, '2019-09-29'),
(7, 4, '2020-10-03'),
(7, 4, '2020-11-04');

INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES 
    ((SELECT animal_id FROM animals WHERE name = 'Blossom'), 
     (SELECT owner_id FROM animals WHERE name = 'Blossom'), 
     '2020-05-24'),
    ((SELECT animal_id FROM animals WHERE name = 'Blossom'), 
     (SELECT owner_id FROM animals WHERE name = 'Blossom'), 
     '2021-01-11');
ALTER TABLE animals ADD COLUMN id SERIAL PRIMARY KEY;

ALTER TABLE owners ADD COLUMN email VARCHAR(120);
INSERT INTO visits (animal_id, vet_id, visit_date) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;
-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';

