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