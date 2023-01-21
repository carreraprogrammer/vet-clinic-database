/* Populate database with sample data. */

INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg)
SELECT 'Agumon', '2020-02-03', 0, true, 10.23
UNION
SELECT 'Gabumon', '2018-11-15', 2, true, 8
UNION
SELECT 'Pikachu', '2021-01-07', 1, false, 15.04
UNION
SELECT 'Devimon', '2017-05-12', 5, true, 11;

/*  Insert the provided data */

BEGIN;

INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Charmander', '2020-02-08', 0, false, -11), 
       ('Plantmon', '2021-11-15', 2, true, -5.7), 
       ('Squirtle', '1993-04-02', 3, false, -12.13), 
       ('Angemon', '2005-06-12', 1, true, -45), 
       ('Boarmon', '2005-06-07', 7, true, 20.4), 
       ('Blossom', '1998-10-13', 3, true, 17), 
       ('Ditto', '2022-05-14', 4, true, 22);

COMMIT;

/* Insert data in the owners table */

BEGIN;

INSERT INTO owners(full_name, age)
VALUES ('Sam Smith', 34),
       ('Jennifer Orwell', 19),
       ('Bob', 45),
       ('Melody Pond', 77),
       ('Dean Winchester', 14),
       ('Jodie Whittaker', 38);

COMMIT;

/* Insert data in species table */

BEGIN;

INSERT INTO species(name)
VALUES ('Pokemon'),
       ('Digimon');

COMMIT;

/* Include owner information in animals table */

UPDATE animals
SET owner_id = 
    CASE 
    WHEN name = 'Agumon' THEN 1
    WHEN name = 'Gabumon' OR name = 'Pikachu' THEN 2
    WHEN name = 'Devimon' OR name = 'Plantmon' THEN 3
    WHEN name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom' THEN 4
    WHEN name = 'Angemon' OR name = 'Boarmon' THEN 5
    ELSE NULL
    END;

/* Modify your inserted animals so it includes the species_id value: */

UPDATE animals
SET species_id =
    CASE
    WHEN name LIKE '%mon' THEN 2
    ELSE 1
    END;
    