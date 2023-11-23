-- postgreSQL     : create_tables_soundgood_db.sql
-- Module         : task 2
-- Description    : Seminar 2, Conceptual Model
--                 
-- Course         : kth IV1351 Data Storage Paradigms
-- Author/Student : Elin Blomquist, Vincent Ferrigan
-- maintainer     : eblomq@kth.se, ferrigan@kth.se,

CREATE TABLE "student" (
  "id" SERIAL,
  "person_id" INT UNIQUE  NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "contact_person" (
  "id" SERIAL,
  "contact_details_id" INT  NOT NULL,
  "full_name" VARCHAR(100)  NOT NULL,
  "last_name" VARCHAR(100)  NOT NULL,
  "phone" VARCHAR(50)  NOT NULL,
  "email" VARCHAR(100)  NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "student_contact_person" (
  "student_id" INT  NOT NULL,
  "contact_person_id" INT  NOT NULL,
  "relation" VARCHAR(100)  NOT NULL,
  PRIMARY KEY ("student_id", "contact_person_id"),
  CONSTRAINT "FK_student_contact_person.contact_person_id"
    FOREIGN KEY ("contact_person_id")
      REFERENCES "contact_person"("id"),
  CONSTRAINT "FK_student_contact_person.student_id"
    FOREIGN KEY ("student_id")
      REFERENCES "student"("id")
);

CREATE TABLE "instructor_instrument" (
  "instructor_id" INT  NOT NULL,
  "instrument_id" INT  NOT NULL,
  PRIMARY KEY ("instructor_id", "instrument_id")
);

CREATE TABLE "siblings" (
  "id" SERIAL,
  "sibling_1" INT NOT NULL,
  "sibling_2" INT NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "discount" (
  "id" SERIAL,
  "type_of_discount" VARCHAR(100),
  "discount_rate" FLOAT4,
  PRIMARY KEY ("id")
);

CREATE TABLE "student_booking" (
  "student_id" INT  NOT NULL,
  "session_id" INT  NOT NULL,
  PRIMARY KEY ("student_id", "session_id"),
  CONSTRAINT "FK_student_booking.student_id"
    FOREIGN KEY ("student_id")
      REFERENCES "student"("id")
);

CREATE TABLE "brand" (
  "id" SERIAL,
  "name" VARCHAR(100)  UNIQUE  NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "genre" (
  "id" SERIAL,
  "name" VARCHAR(100)  NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "ensemble" (
  "id" SERIAL,
  "session_id" INT  NOT NULL,
  "genre" INT  NOT NULL,
  "min_nr_of_students" INT  NOT NULL,
  "max_nr_of_students" INT  NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_ensemble.genre"
    FOREIGN KEY ("genre")
      REFERENCES "genre"("id")
);

CREATE TABLE "instrument" (
  "id" SERIAL,
  "name" VARCHAR(100)  UNIQUE  NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "rentable_instrument" (
  "id" SERIAL,
  "instrument_id" INT  NOT NULL,
  "brand_id" INT  NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_rentable_instrument.brand_id"
    FOREIGN KEY ("brand_id")
      REFERENCES "brand"("id"),
  CONSTRAINT "FK_rentable_instrument.instrument_id"
    FOREIGN KEY ("instrument_id")
      REFERENCES "instrument"("id")
);

CREATE TABLE "skill_levels" (
  "id" SERIAL,
  "level" VARCHAR(100)  UNIQUE  NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "individual_lesson_price" (
  "id" SERIAL,
  "instrument_id" INT  NOT NULL,
  "skill_level_id" INT  NOT NULL,
  "price" MONEY NOT NULL,
  "effective_date" MONEY  NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_individual_lesson_price.skill_level_id"
    FOREIGN KEY ("skill_level_id")
      REFERENCES "skill_levels"("id"),
  CONSTRAINT "FK_individual_lesson_price.instrument_id"
    FOREIGN KEY ("instrument_id")
      REFERENCES "instrument"("id")
);

CREATE TABLE "person" (
  "id" SERIAL,
  "personal_identity_number " CHAR(12) UNIQUE  NOT NULL,
  "full_name" VARCHAR(100) NOT NULL,
  "last_name" VARCHAR(100) NOT NULL,
  "street" VARCHAR(100)  NOT NULL,
  "zip" VARCHAR(10)   NOT NULL,
  "city" VARCHAR(100)  NOT NULL,
  "phone" VARCHAR(50)  NOT NULL,
  "email" VARCHAR(100)  NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "group_lesson" (
  "id" SERIAL,
  "session_id" INT  NOT NULL,
  "instrument_id" INT  NOT NULL,
  "skill_level_id" INT  NOT NULL,
  "min_nr_of_students" INT  NOT NULL,
  "max_nr_of_students" INT  NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_group_lesson.skill_level_id"
    FOREIGN KEY ("skill_level_id")
      REFERENCES "skill_levels"("id"),
  CONSTRAINT "FK_group_lesson.instrument_id"
    FOREIGN KEY ("instrument_id")
      REFERENCES "instrument"("id")
);

CREATE TABLE "instrument_price_list" (
  "id" SERIAL,
  "instrument_id" VARCHAR(100)  UNIQUE  NOT NULL,
  "price_per_month" MONEY NOT NULL,
  "effective_date" DATE  NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "ensemble_price" (
  "id" SERIAL,
  "genre_id" INT  NOT NULL,
  "price" INT NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_ensemble_price.genre_id"
    FOREIGN KEY ("genre_id")
      REFERENCES "genre"("id")
);

CREATE TABLE "instructor" (
  "id" SERIAL,
  "person_id" INT  UNIQUE  NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "instructor_booking" (
  "instructor_id" INT  NOT NULL,
  "session_id" INT  NOT NULL,
  PRIMARY KEY ("instructor_id", "session_id"),
  CONSTRAINT "FK_instructor_booking.instructor_id"
    FOREIGN KEY ("instructor_id")
      REFERENCES "instructor"("id")
);

CREATE TABLE "group_lesson_price" (
  "id" SERIAL,
  "instrument_id" INT  NOT NULL,
  "skill_level_id" INT  NOT NULL,
  "price" MONEY NOT NULL,
  "effective_date" DATE  NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_group_lesson_price.skill_level_id"
    FOREIGN KEY ("skill_level_id")
      REFERENCES "skill_levels"("id"),
  CONSTRAINT "FK_group_lesson_price.instrument_id"
    FOREIGN KEY ("instrument_id")
      REFERENCES "instrument"("id")
);

CREATE TABLE "individual_lesson" (
  "id" SERIAL,
  "session_id" INT  NOT NULL,
  "instrument_id" INT  NOT NULL,
  "skill_level_id" INT  NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_individual_lesson.instrument_id"
    FOREIGN KEY ("instrument_id")
      REFERENCES "instrument"("id"),
  CONSTRAINT "FK_individual_lesson.skill_level_id"
    FOREIGN KEY ("skill_level_id")
      REFERENCES "skill_levels"("id")
);

CREATE TABLE "rentals" (
  "id" SERIAL,
  "student_id" INT  NOT NULL,
  "rentable_instrument_id" INT  NOT NULL,
  "time_of_rent" TIMESTAMP  NOT NULL,
  "return_time" TIMESTAMP,
  "lease_time" TIMESTAMP  NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "session" (
  "id" SERIAL,
  "start_time" TIMESTAMP  NOT NULL,
  "end_time" TIMESTAMP  NOT NULL,
  PRIMARY KEY ("id")
);


