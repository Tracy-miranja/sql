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

.......................................
SELECT a.name
FROM animals a
JOIN visits v ON a.animal_id = v.animal_id
WHERE a.owner_id = 4
ORDER BY v.visit_date DESC
LIMIT 1;

SELECT COUNT(DISTINCT animal_id) AS num_animals_seen
FROM visits
WHERE vet_id = (SELECT vet_id FROM vets WHERE name = 'Stephanie Mendez');

SELECT a.name, a.date_of_birth, a.escape_attempts, a.neutered, a.neutered_weight_kg, a.animal_id, a.species_id, a.owner_id
FROM visits v
JOIN animals a ON v.animal_id = a.animal_id
JOIN owners o ON a.owner_id = a.owner_id
WHERE o.name = 'Stephanie Mendez'
AND v.visit_date >= '2020-04-01'
AND v.visit_date <= '2020-08-30';

SELECT a.name AS animal_name, COUNT(*) AS num_visits
FROM visits v
JOIN animals a ON v.animal_id = a.animal_id
GROUP BY a.name
ORDER BY num_visits DESC
LIMIT 1;

SELECT animals.*, vets.*, visits.visit_date
FROM visits
JOIN animals ON visits.animal_id = animals.animal_id
JOIN vets ON visits.vet_id = vets.vet_id
ORDER BY visit_date DESC
LIMIT 1;

SELECT animals.name AS animal_name, vets.name AS vet_name, visits.date_of_visit
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vets_id = vets.id
ORDER BY visits.date_of_visit DESC
LIMIT 1;

SELECT vets.name, COALESCE(species.name, 'No Specialties') as specialty
FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON specializations.species_id = species.id;

SELECT visits.visit_date
FROM visits
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.visit_date ASC
LIMIT 1;

SELECT a.species_id, COUNT(*) AS num_visits
FROM vets v
JOIN visits vs ON v.id = vs.vet_id
JOIN animals a ON vs.animal_id = a.animal_id
WHERE v.name = 'Maisy Smith'
GROUP BY a.species_id
ORDER BY num_visits DESC
LIMIT 1;

SELECT COUNT(*) 
FROM visits 
JOIN animals ON visits.animal_id = animals.animal_id 
JOIN vets ON visits.vet_id = vets.id 
LEFT JOIN specializations ON vets.id = specializations.vet_id AND animals.species_id = specializations.species_id 
WHERE specializations.vet_id IS NULL;


