SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE neutered_weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE neutered_weight_kg >= 10.4 AND neutered_weight_kg <= 17.3;
BEGIN;
SAVEPOINT S1;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals; 
ROLLBACK TO S1;
SELECT * FROM animals;
UPDATE animals SET species = 'digimon' where name like '%mon';
UPDATE animals SET species = 'pokemon' where species IS NULL OR species = '';
SELECT name, species FROM animals;
COMMIT;
SELECT name, species FROM animals;
BEGIN; 
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT S2;
UPDATE animals SET neutered_weight_kg = neutered_weight_kg * -1;
ROLLBACK TO SAVEPOINT S2;
UPDATE animals SET neutered_weight_kg = neutered_weight_kg * -1 WHERE neutered_weight_kg < 0;
COMMIT;
SELECT COUNT(name) from animals;
SELECT COUNT(name) from animals GROUP BY escape_attempts HAVING escape_attempts = 0;
SELECT neutered, AVG(escape_attempts) as avg_escapes FROM animals GROUP BY neutered;
SELECT AVG( neutered_weight_kg) FROM animals;
SELECT neutered, AVG(escape_attempts) as avg_escapes FROM animals GROUP BY neutered;
SELECT species, MIN(neutered_weight_kg) as min_weight, MAX(neutered_weight_kg) as max_weight FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) as avg_escape_attempts FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';

SELECT a.name
FROM animals a
JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

SELECT o.full_name, a.name
FROM owners o
LEFT JOIN animals a ON a.owner_id = o.id;

SELECT s.name, COUNT(a.animal_id) as count
FROM species s
LEFT JOIN animals a ON a.species_id = s.id
GROUP BY s.name;

SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
JOIN species s ON a.species_id = s.id
WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

SELECT o.full_name, COUNT(a.animal_id) as count
FROM owners o
LEFT JOIN animals a ON a.owner_id = o.id
GROUP BY o.full_name
ORDER BY count DESC
LIMIT 1;
