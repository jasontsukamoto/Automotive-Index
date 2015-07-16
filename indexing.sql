-- create a new postgres user
CREATE USER indexed_cars_user;

-- create a new database named indexed_cars owned by indexed_cars_user
CREATE DATABASE indexed_car;

-- combine 2 steps above
CREATE DATABASE indexed_car WITH OWNER indexed_cars_user;

\i ~/DevLeague/Automotive-Index/scripts/car_models.sql;

\i ~/DevLeague/Automotive-Index/scripts/car_model_data.sql;

-- check how many rows are in table
SELECT COUNT(*) FROM car_models;


------------ enable timing queries -------------------
--get a list of all make_title values from car_models table where make code is 'LAM' without duplicate rows somewhere
SELECT DISTINCT make_title
FROM car_models
WHERE make_code = 'LAM';
  -- 24.853 ms
    --1.438
  -- 2.398 ms

-- write a query to list all model_title values where the make_code is 'Nissan' and the model_code is 'GT-R' without duplicate rows
SELECT DISTINCT model_title
FROM car_models
WHERE make_code ='NISSAN' AND model_code = 'GT-R';
  -- 23.893 ms
    --2.374
  -- 2.716

-- run a query to list all make_code, model_code, model_title and year from car_models where make_code is 'LAM'
SELECT make_code, model_code, model_title, year
FROM car_models
WHERE make_code = 'LAM';
  --time 25.226 ms
    --1.753
  --1.854

--
SELECT *
FROM car_models
WHERE year BETWEEN 2010 AND 2015;
  --time 71.807 ms
    --53.895
  --50.987
--

SELECT *
FROM car_models
WHERE year = 2010;
  --36.054 ms
    --14.620
  --14.834

-------------------- indexing ------------------------
CREATE INDEX make_code_idx
ON car_models (make_code);

CREATE INDEX year_idx
ON car_models (year);