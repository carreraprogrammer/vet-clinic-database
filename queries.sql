/* Find all animals whose name ends in "mon". */

    SELECT * FROM animals
    WHERE name LIKE '%mon';

/* List the name of all animals born between 2016 and 2019. */

    SELECT name FROM animals
    WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

/* List the name of all animals that are neutered and have less than 3 escape attempts. */

    SELECT name FROM animals
    WHERE neutered = true AND escape_attempts < 3;

/* List the date of birth of all animals named either "Agumon" or "Pikachu". */

    SELECT date_of_birth FROM animals
    WHERE name = 'Agumon' OR name = 'Pikachu';

/* List name and escape attempts of animals that weigh more than 10.5kg */

    SELECT name, escape_attempts FROM animals
    WHERE weight_kg > 10.5;

/* Find all animals that are neutered. */

    SELECT * FROM animals
    WHERE neutered = true;

/* Find all animals not named Gabumon. */

    SELECT * FROM animals
    WHERE name != 'Gabumon';

/* Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg) */

    SELECT * FROM animals
    WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

/* Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction. */

BEGIN;

UPDATE animals SET species='unspecified';

SELECT * FROM animals;

ROLLBACK;

/* Change the species from animals ended in mon */

BEGIN;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

SELECT * FROM animals

COMMIT;

SELECT * FROM animals

/* Inside a transaction delete all records in the animal's table, then roll back the transaction. */

BEGIN;

DELETE FROM animals;

SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;

/* Delete all animals born after Jan 1st, 2022. */

BEGIN;

DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

SAVEPOINT SP1;

UPDATE animals
SET weight_kg = weight_kg * -1;

ROLLBACK TO SP1

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg  < 0;

COMMIT;

 /* How many animals are there? */

SELECT COUNT(*) FROM animals;

/* How many animals have never tried to escape? */

SELECT COUNT(*) FROM animals
WHERE escape_attempts = 0;

/* What is the average weight of animals? */

SELECT AVG(weight_kg) FROM animals;

/* Who escapes the most, neutered or not neutered animals? */

SELECT neutered, SUM(escape_attempts)
FROM animals
GROUP BY neutered;

SELECT neutered, ROUND(AVG(escape_attempts), 2)
FROM animals
GROUP BY neutered;

/* What is the minimum and maximum weight of each type of animal? */

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

/* What is the average number of escape attempts per animal type of those born between 1990 and 2000? */

SELECT species, AVG(escape_attempts)
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

/* What animals belong to Melody Pond?*/

SELECT a.name, o.full_name
FROM animals a
JOIN owners o
ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';

/*  List of all animals that are pokemon (their type is Pokemon). */

SELECT a.name, s.name
FROM animals a
JOIN species s
ON a.species_id = s.id
WHERE s.name = 'Pokemon';

/* List all owners and their animals, remember to include those that don't own any animal */

SELECT a.name, o.full_name
FROM owners o
LEFT JOIN animals a
ON o.id = a.owner_id;

/* How many animals are there per species? */

SELECT s.name AS specie, COUNT(*) AS total_animals
FROM animals a
JOIN species s
ON a.species_id = s.id
GROUP BY s.name;

/* List all Digimon owned by Jennifer Orwell. */

SELECT a.name, o.full_name, s.name
FROM animals a
JOIN species s
ON a.species_id = s.id
JOIN owners o
ON a.owner_id = o.id
WHERE o.full_name = 'Jennifer Orwell' AND s.name ='Digimon';

/* List all animals owned by Dean Winchester that haven't tried to escape. */

SELECT a.name, a.escape_attempts, o.full_name AS owner
FROM animals a
JOIN owners o
ON a.owner_id = o.id
WHERE a.escape_attempts = 0 AND owner = "Dean Winchester";

/* Who owns the most animals? */

SELECT o.full_name, COUNT(*) AS number_of_animals
FROM owners o
JOIN animals a
ON a.owner_id = o.id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

/* Who was the last animal seen by William Tatcher? */

SELECT a.name, v.name, d.date_of_visits
FROM animals a
JOIN visits d
ON a.id = d.animal_id
JOIN vets v
ON v.id = d.vet_id
WHERE v.name = 'William Tatcher'
ORDER BY d.date_of_visits DESC
LIMIT 1;

/* How many different animals did Stephanie Mendez see? */

SELECT v.name, COUNT(a.id) AS animals_seen
FROM animals a
JOIN visits d
ON a.id = d.animal_id
JOIN vets v
ON v.id = d.vet_id
GROUP BY v.name
HAVING v.name = 'Stephanie Mendez';