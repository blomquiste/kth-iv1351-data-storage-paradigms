-- postgreSQL
-- file           : create_tables_soundgood_db.sql
-- Module         : Script for table creation
-- Description    : Seminar 2, Conceptual Model
--                 
-- Course         : kth IV1351 Data Storage Paradigms
-- Author/Student : Elin Blomquist, Vincent Ferrigan
-- maintainer     : eblomq@kth.se, ferrigan@kth.se,

-- Create a table to store various configuration settings
-- Magic numbers are subject to change or might differ based on business logic,
-- OPEN ISSUE: the script for creating the system_configuration table fits well
-- in a schema or database directory within src/, while the script for inserting
-- configuration keys and values could go into either config/ or a data-seeding
-- directory within src/, depending on how you view these configurations in the
-- context of your application setup and deployment.
CREATE TABLE system_configuration (
    config_key VARCHAR(100) PRIMARY KEY,
    config_value INT
);

CREATE TABLE "person" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "personal_identity_number" CHAR(13) UNIQUE NOT NULL,
  "first_name" VARCHAR(100) NOT NULL,
  "last_name" VARCHAR(100) NOT NULL,
  "street" VARCHAR(100) NOT NULL,
  "zip" VARCHAR(10) NOT NULL,
  "city" VARCHAR(100) NOT NULL,
  "phone" VARCHAR(50) NOT NULL,
  "email" VARCHAR(100) NOT NULL
);

CREATE TABLE "session" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "start_time" TIMESTAMP NOT NULL,
  "end_time" TIMESTAMP NOT NULL
);

CREATE TABLE "instrument" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "name" VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE "skill_level" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "name" VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE "genre" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "name" VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE "brand" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "name" VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE "discount" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "type_of_discount" VARCHAR(100),
  "discount_rate" FLOAT4
);

CREATE TABLE "contact_person" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "first_name" VARCHAR(100) NOT NULL,
  "last_name" VARCHAR(100) NOT NULL,
  "phone" VARCHAR(50) NOT NULL,
  "email" VARCHAR(100) NOT NULL
);

CREATE TABLE "student" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "person_id" INT UNIQUE NOT NULL,
  CONSTRAINT "fk.person"
    FOREIGN KEY ("person_id")
      REFERENCES "person"("id")
      ON DELETE CASCADE
);

CREATE TABLE "sibling" (
  "sibling_1" INT NOT NULL,
  "sibling_2" INT NOT NULL CHECK ("sibling_2" > "sibling_1"),
  CONSTRAINT "fk.student_1"
    FOREIGN KEY ("sibling_1")
      REFERENCES "student"("id")
      ON DELETE CASCADE,
  CONSTRAINT "fk.student_2"
    FOREIGN KEY ("sibling_2")
      REFERENCES "student"("id")
      ON DELETE CASCADE,
  PRIMARY KEY ("sibling_1", "sibling_2")
);

CREATE TABLE "student_contact_person" (
  "student_id" INT NOT NULL,
  "contact_person_id" INT NOT NULL,
  "relation" VARCHAR(100) NOT NULL,
  CONSTRAINT "fk.student"
    FOREIGN KEY ("student_id")
      REFERENCES "student"("id")
      ON DELETE CASCADE,
  CONSTRAINT "fk.contact_person"
    FOREIGN KEY ("contact_person_id")
      REFERENCES "contact_person"("id")
      ON DELETE CASCADE,
  PRIMARY KEY ("student_id", "contact_person_id")
);

CREATE TABLE "instructor" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "person_id" INT UNIQUE NOT NULL,
  CONSTRAINT "fk.person"
    FOREIGN KEY ("person_id")
      REFERENCES "person"("id")
      ON DELETE CASCADE
);

-- CREATE TABLE "instructor_booking" (
--   "instructor_id" INT NOT NULL,
--   "session_id" INT UNIQUE NOT NULL,
--   CONSTRAINT "fk.instructor"
--     FOREIGN KEY ("instructor_id")
--       REFERENCES "instructor"("id"),
--   CONSTRAINT "fk.session"
--     FOREIGN KEY ("session_id")
--       REFERENCES "session"("id"),
--   PRIMARY KEY ("instructor_id", "session_id")
-- );

CREATE TABLE "student_booking" (
  "student_id" INT NOT NULL,
  "session_id" INT NOT NULL,
  CONSTRAINT "fk.student"
    FOREIGN KEY ("student_id")
      REFERENCES "student"("id"),
  CONSTRAINT "fk.session"
    FOREIGN KEY ("session_id")
      REFERENCES "session"("id"),
  PRIMARY KEY ("student_id", "session_id")
);

CREATE TABLE "instructor_instrument" (
  "instructor_id" INT NOT NULL,
  "instrument_id" INT NOT NULL,
  CONSTRAINT "fk.instructor"
    FOREIGN KEY ("instructor_id")
      REFERENCES "instructor"("id")
      ON DELETE CASCADE,
  CONSTRAINT "fk.instrument"
    FOREIGN KEY ("instrument_id")
      REFERENCES "instrument"("id")
      ON DELETE CASCADE,
  PRIMARY KEY ("instructor_id", "instrument_id")
);

CREATE TABLE "rentable_instrument" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "instrument_id" INT NOT NULL,
  "brand_id" INT NOT NULL,
  CONSTRAINT "fk.instrument"
    FOREIGN KEY ("instrument_id")
      REFERENCES "instrument"("id"),
  CONSTRAINT "fk.brand"
    FOREIGN KEY ("brand_id")
      REFERENCES "brand"("id")
);

CREATE TABLE "rentals" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "student_id" INT NOT NULL,
  "rentable_instrument_id" INT NOT NULL, 
  -- Check that only one student can rent the rentable at a time
  "time_of_rent" TIMESTAMP NOT NULL,
  "return_time" TIMESTAMP,
  -- Should these times be treated a valid times. And if so, should we add transactions times?
  -- return_time is nullable. Is there a way to fix this?
  "lease_end_time" TIMESTAMP NOT NULL,
  -- CHECK if lease_end_time is max 12 months after time_of_rent
  -- default lease_end_time 12 months after time_of_rent
  -- TODO Should it be connected to some kind of business logic table????
  CONSTRAINT "fk.student"
    FOREIGN KEY ("student_id")
      REFERENCES "student"("id"),
  CONSTRAINT "fk.rentable_instrument"
    FOREIGN KEY ("rentable_instrument_id")
      REFERENCES "rentable_instrument"("id")
);

CREATE TABLE "group_lesson" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "session_id" INT NOT NULL,
  "instrument_id" INT NOT NULL,
  "skill_level_id" INT NOT NULL,
  "min_nr_of_students" INT NOT NULL,
  "max_nr_of_students" INT NOT NULL,
  CONSTRAINT "fk.session"
    FOREIGN KEY ("session_id")
      REFERENCES "session"("id"),
  CONSTRAINT "fk.instrument"
    FOREIGN KEY ("instrument_id")
      REFERENCES "instrument"("id"),
  CONSTRAINT "fk.skill_level"
    FOREIGN KEY ("skill_level_id")
      REFERENCES "skill_level"("id")
);


CREATE TABLE "individual_lesson" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "session_id" INT NOT NULL,
  "instrument_id" INT NOT NULL,
  "skill_level_id" INT NOT NULL,
  CONSTRAINT "fk.session"
    FOREIGN KEY ("session_id")
      REFERENCES "session"("id"),
  CONSTRAINT "fk.instrument"
    FOREIGN KEY ("instrument_id")
      REFERENCES "instrument"("id"),
  CONSTRAINT "fk.skill_level"
    FOREIGN KEY ("skill_level_id")
      REFERENCES "skill_level"("id")
);

CREATE TABLE "ensemble" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "session_id" INT NOT NULL,
  "genre_id" INT NOT NULL,
  "min_nr_of_students" INT NOT NULL,
  "max_nr_of_students" INT NOT NULL,
  CONSTRAINT "fk.session"
    FOREIGN KEY ("session_id")
      REFERENCES "session"("id"),
  CONSTRAINT "fk.genre"
    FOREIGN KEY ("genre_id")
      REFERENCES "genre"("id")
);

-- New table not in diagram
-- This table stores basic information about each course type
-- individual, group, ensemble
CREATE TABLE "course_type" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "name" VARCHAR(100) UNIQUE NOT NULL
  -- "course_description" VARCHAR(500) NOT NULL, ev 
  -- "min_nr_of_students" INT NOT NULL, -- ev 
  -- "max_nr_of_students" INT NOT NULL, -- ev 
);

-- This table will store the pricing information for the courses/lessons. It will link to the Courses
-- table and, where applicable, to the Skill Levels and Instruments tables.
-- Add ALTER CONSTRAINTS after you created the ensemble course
CREATE TABLE "lesson_price_list" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "course_type_id" INT NOT NULL,
  "instrument_id" INT, -- where "null" means "default price"
  "skill_level_id" INT, -- where "null" means "default price"
  -- CURRENCY??
  "price" FLOAT4 NULL,
  "valid_start_time" DATE NOT NULL,
  "valid_end_time" DATE, -- where "null" means "now"
  "transaction_start_time" TIMESTAMP NOT NULL,
  "transaction_end_time" TIMESTAMP, -- where "null" means "uc" (until changed)
  -- NULLABLE END DATE???
  CONSTRAINT "fk.course_type"
    FOREIGN KEY ("course_type_id")
      REFERENCES "course_type"("id"),
  CONSTRAINT "fk.instrument"
    FOREIGN KEY ("instrument_id")
      REFERENCES "instrument"("id"),
  CONSTRAINT "fk.skill_level"
    FOREIGN KEY ("skill_level_id")
      REFERENCES "skill_level"("id")
);

-- A session is a instructor booking one can say... ELABORATE HERE!!
-- A lesson instance one can say.
CREATE TABLE "session" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "course_type_id" INT NOT NULL,
  "instructor_id" INT NOT NULL,
  "start_time" TIMESTAMP NOT NULL,
  "end_time" TIMESTAMP NOT NULL,
  CONSTRAINT "fk.course_type"
    FOREIGN KEY ("course_type_id")
      REFERENCES "course_type"("id"),
  CONSTRAINT "fk.instructor"
    FOREIGN KEY ("instructor_id")
      REFERENCES "instructor"("id")
);

-- New table not in diagram
CREATE TABLE "rental_price_list" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "instrument_id" INT NOT NULL,
  -- "brand_id" INT NOT NULL, -- ev
  -- CURRENCY??
  "price_per_month" FLOAT4 NOT NULL,
  -- "effective_date" DATE NOT NULL,
  -- -- NULLABLE END DATE or OUTGOING BOOLEAN???
  "valid_start_time" DATE NOT NULL,
  "valid_end_time" DATE, -- where "null" means "now"
  "transaction_start_time" TIMESTAMP NOT NULL,
  "transaction_end_time" TIMESTAMP, -- where "null" means "uc" (until changed)
  CONSTRAINT "fk.instrument"
    FOREIGN KEY ("instrument_id")
      REFERENCES "instrument"("id")
      ON DELETE CASCADE
  -- -- EV EV:
  -- CONSTRAINT "fk.brand"
  --   FOREIGN KEY ("brand_id")
  --     REFERENCES "brand"("id")
  --     ON DELETE CASCADE
);

-- -- Add ALTER CONSTRAINTS after you created the individual lesson course_type
-- -- Create a function for adding lessons
-- -- Add ALTER CONSTRAINTS after you created the individual lesson course_type
-- -- Create a function for adding lessons
-- CREATE TABLE "lesson" (
--   "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
--   "course_type_id" INT NOT NULL,
--   "session_id" INT NOT NULL,
--   "instrument_id" INT NOT NULL,
--   "skill_level_id" INT NOT NULL,
--   "min_nr_of_students" INT NOT NULL, -- Always 1 if individual lesson course type
--   "max_nr_of_students" INT NOT NULL,
--   CONSTRAINT "fk.course_type"
--     FOREIGN KEY ("course_type_id")
--       REFERENCES "course_type"("id"),
--   CONSTRAINT "fk.session"
--     FOREIGN KEY ("session_id")
--       REFERENCES "session"("id"),
--   CONSTRAINT "fk.instrument"
--     FOREIGN KEY ("instrument_id")
--       REFERENCES "instrument"("id"),
--   CONSTRAINT "fk.skill_level"
--     FOREIGN KEY ("skill_level_id")
--       REFERENCES "skill_level"("id")
-- );