/* Populate database with sample data. */

INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg)
SELECT 'Agumon','2020-02-03',0, true,10.23
UNION
SELECT 'Gabumon','2018-11-15',2, true,8
UNION
SELECT 'Pikachu','2021-01-07',1, false,15.04
UNION
SELECT 'Devimon','2017-05-12',5, true,11;