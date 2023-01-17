/* Find all animals whose name ends in "mon". */

    SELECT * FROM animals
    WHERE name LIKE '%mon';

/* List the name of all animals born between 2016 and 2019. */

    SELECT * FROM animals
    WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

/* List the name of all animals that are neutered and have less than 3 escape attempts. */

    SELECT * FROM animals
    WHERE neutered = true AND escape_attempts < 3;