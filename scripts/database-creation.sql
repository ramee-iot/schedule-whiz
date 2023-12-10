
-- Generate ScheduleWhiz sample database

DROP SCHEMA IF EXISTS "schedule-whiz-v1" CASCADE;
CREATE SCHEMA "schedule-whiz-v1";

-- This script was generated by the ERD tool in pgAdmin 4.
-- Please log an issue at https://github.com/pgadmin-org/pgadmin4/issues/new/choose if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS "schedule-whiz-v1"."Employees"
(
    employee_id serial NOT NULL,
    names character varying(50) NOT NULL,
    first_surname character varying(50) NOT NULL,
    second_surname character varying(50) NOT NULL,
    fk_schedule integer,
    fk_team serial NOT NULL,
    fk_managed_team integer,
    CONSTRAINT "Employees_pkey" PRIMARY KEY (employee_id),
    UNIQUE (fk_managed_team)
);

CREATE TABLE IF NOT EXISTS "schedule-whiz-v1"."Schedules"
(
    schedule_id serial NOT NULL,
    name character varying(50) NOT NULL,
    start_time time with time zone NOT NULL,
    end_time time with time zone NOT NULL,
    max_employees integer,
    current_employees integer,
    PRIMARY KEY (schedule_id)
);

CREATE TABLE IF NOT EXISTS "schedule-whiz-v1"."Teams"
(
    team_id serial NOT NULL,
    name character varying(100),
    PRIMARY KEY (team_id),
    UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS "schedule-whiz-v1"."Records"
(
    record_id serial NOT NULL,
    fk_employee serial NOT NULL,
    created timestamp with time zone NOT NULL,
    fk_schedule serial NOT NULL,
    fk_issue integer,
    PRIMARY KEY (record_id),
    UNIQUE (fk_issue)
);

CREATE TABLE IF NOT EXISTS "schedule-whiz-v1"."Issues"
(
    issue_id serial NOT NULL,
    fk_issue_status serial NOT NULL,
    delay time without time zone,
    description character varying(280),
    PRIMARY KEY (issue_id)
);

CREATE TABLE IF NOT EXISTS "schedule-whiz-v1"."Issue_statuses"
(
    issue_status_id serial NOT NULL,
    name character varying(50) NOT NULL,
    PRIMARY KEY (issue_status_id)
);

ALTER TABLE IF EXISTS "schedule-whiz-v1"."Employees"
    ADD FOREIGN KEY (fk_team)
    REFERENCES "schedule-whiz-v1"."Teams" (team_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS "schedule-whiz-v1"."Employees"
    ADD FOREIGN KEY (fk_schedule)
    REFERENCES "schedule-whiz-v1"."Schedules" (schedule_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS "schedule-whiz-v1"."Employees"
    ADD FOREIGN KEY (fk_managed_team)
    REFERENCES "schedule-whiz-v1"."Teams" (team_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS "schedule-whiz-v1"."Records"
    ADD FOREIGN KEY (fk_employee)
    REFERENCES "schedule-whiz-v1"."Employees" (employee_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS "schedule-whiz-v1"."Records"
    ADD FOREIGN KEY (fk_issue)
    REFERENCES "schedule-whiz-v1"."Issues" (issue_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS "schedule-whiz-v1"."Records"
    ADD FOREIGN KEY (fk_schedule)
    REFERENCES "schedule-whiz-v1"."Schedules" (schedule_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS "schedule-whiz-v1"."Issues"
    ADD FOREIGN KEY (fk_issue_status)
    REFERENCES "schedule-whiz-v1"."Issue_statuses" (issue_status_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;


-- Populate database

TRUNCATE TABLE  "schedule-whiz-v1"."Teams"  RESTART IDENTITY CASCADE;
TRUNCATE TABLE  "schedule-whiz-v1"."Employees"  RESTART IDENTITY CASCADE;
TRUNCATE TABLE  "schedule-whiz-v1"."Issues"  RESTART IDENTITY CASCADE;
TRUNCATE TABLE  "schedule-whiz-v1"."Schedules"  RESTART IDENTITY CASCADE;
TRUNCATE TABLE  "schedule-whiz-v1"."Records"  RESTART IDENTITY CASCADE;
TRUNCATE TABLE  "schedule-whiz-v1"."Issue_statuses"  RESTART IDENTITY CASCADE;

-- Add sample teams
INSERT INTO "schedule-whiz-v1"."Teams"(name)
VALUES ('Development Team'),
    ('Quality Assurance (QA) Team'),
    ('Product Management Team'),
    ('UI/UX Design Team'),
    ('Network and Infrastructure Team'),
    ('Security Team'),
    ('Data Analytics Team'),
    ('Sales and Marketing Team'),
    ('Customer Support Team'),
    ('Research and Development (R&D) Team');
	
-- Add statuses
INSERT INTO "schedule-whiz-v1"."Issue_statuses"(name)
VALUES ('Late'),
	('Early'),
	('Missed'),
	('Blocked'),
	('Punctual');

-- Add schedules
INSERT INTO "schedule-whiz-v1"."Schedules"(name, start_time, end_time, max_employees, current_employees)
VALUES
    ('7:00-15:30', '07:00:00-06:00', '15:30:00-06:00', 2, 0),
    ('7:30-16:00', '07:30:00-06:00', '16:00:00-06:00', 2, 0),
    ('8:00-16:30', '08:00:00-06:00', '16:30:00-06:00', 3, 0),
    ('8:30-17:00', '08:30:00-06:00', '17:00:00-06:00', 4, 0),
    ('9:00-17:30', '09:00:00-06:00', '17:30:00-06:00', 5, 0),
    ('9:30-18:00', '09:30:00-06:00', '18:00:00-06:00', 2, 0),
	('10:00-18:30', '09:30:00-06:00', '18:00:00-06:00', 2, 0);

-- Add employees with a default schema
INSERT INTO "schedule-whiz-v1"."Employees"(names, first_surname, second_surname, fk_schedule, fk_team)
VALUES
 	('John', 'Doe', 'Smith', 5, 1),
 	('Jane', 'Johnson', 'Williams', 5, 2),
  	('Michael', 'Brown', 'Davis', 5, 3),
  	('Emily', 'Wilson', 'Martinez', 5, 4),
  	('Robert', 'Lee', 'Garcia', 5, 5),
  	('Susan', 'Harris', 'Rodriguez', 5, 6),
  	('William', 'Taylor', 'Lopez', 5, 7),
  	('Sarah', 'Clark', 'Hernandez', 5, 5),
  	('David', 'Anderson', 'Gonzalez', 5, 3),
  	('Linda', 'White', 'Perez', 5, 1),
  	('James', 'Moore', 'Sanchez', 5, 1),
  	('Mary', 'Allen', 'Rivera', 5, 2),
  	('Richard', 'Hall', 'Martinez', 5, 3),
  	('Jennifer', 'Young', 'Smith', 5,4),
  	('Charles', 'Lewis', 'Johnson', 5, 5),
	('Patricia', 'Green', 'Brown', 5, 6),
 	('Matthew', 'Scott', 'Davis', 5, 7),
  	('Jessica', 'Adams', 'Williams', 5, 4),
  	('Daniel', 'Turner', 'Harris', 5, 3),
  	('Karen', 'Baker', 'Clark', 5, 5);
 
-- Add managers
INSERT INTO "schedule-whiz-v1"."Employees"(names, first_surname, second_surname, fk_team, fk_managed_team)
VALUES
 	('Jose', 'Smith', 'Smith', 1, 1),
 	('Luis', 'White', 'White', 2, 2),
	('Francisco', 'Turner', 'Turner', 3, 3),
	('Antonio', 'Clark', 'Clark', 4, 4),
	('Isabel', 'Clark', 'Clark', 5, 5),
	('Rosa', 'Lopez', 'Lopez', 7, 7);
