/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg FLOAT,
    PRIMARY KEY(id)
);

/* Add a column species of type string to your animals table. Modify your schema.sql file. */

BEGIN;
ALTER TABLE animals
ADD COLUMN species VARCHAR(200);
COMMIT;

/* Create a table named owners with the following column */

BEGIN;
CREATE TABLE owners(
  id INT GENERATED ALWAYS AS IDENTITY,
  full_name VARCHAR(200),
  age INT,
  PRIMARY KEY(id)
);
COMMIT;

/* Create a table named species */

BEGIN;
CREATE TABLE species(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(200),
    PRIMARY KEY(id)
);
COMMIT;

/* Delete species column */

BEGIN;

ALTER TABLE animals
DROP COLUMN species;

COMMIT;

/* Add column species_id which is a foreign key referencing species table */

BEGIN;

ALTER TABLE animals
ADD COLUMN species_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_species_id
FOREIGN KEY (species_id) 
REFERENCES species(id);

COMMIT;

/* Add column owner_id which is a foreign key referencing the owners table */

BEGIN;

ALTER TABLE animals
ADD COLUMN owner_id INT;

ALTER TABLE animals
ADD CONSTRAINT dk_owner_id
FOREIGN KEY(owner_id)
REFERENCES owners(id);

COMMIT;


/* Create a table named vets with the following columns: */

BEGIN;

CREATE TABLE vets(
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(200),
  age INT,
  date_of_graduation DATE,
  PRIMARY KEY(id)
);