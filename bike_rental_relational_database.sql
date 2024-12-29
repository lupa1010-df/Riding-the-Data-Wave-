--Creating the Relational Database

CREATE TABLE dates (
    date DATE PRIMARY KEY,
    date_id INT
);

CREATE TABLE stations (
    station_id INT PRIMARY KEY,
    station_name VARCHAR(100),
    station_latitude FLOAT,
    station_longitude FLOAT
);

CREATE TABLE users (
    birth_year INT,
    gender INT,
    user_type VARCHAR(20),
    user_id INT PRIMARY KEY
);

CREATE TABLE weather (
    awnd FLOAT,
    prcp FLOAT,
    snow FLOAT,
    snwd FLOAT,
    tavg INT,
    tmax INT,
    tmin INT,
    wdf2 INT,
    wdf5 INT,
    wsf2 FLOAT,
    wsf5 FLOAT,
    weather_id INT PRIMARY KEY,
    date_id INT,
    FOREIGN KEY (date_id) REFERENCES dates(date_id)
);

CREATE TABLE trips (
    trip_duration INT,
    start_time TIMESTAMP,
    stop_time TIMESTAMP,
    start_station_id INT,
    end_station_id INT,
    bike_id INT,
    user_id INT,
    date_id INT,
    trip_id INT PRIMARY KEY,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (date_id) REFERENCES dates(date_id),
    FOREIGN KEY (start_station_id) REFERENCES stations(station_id),
    FOREIGN KEY (end_station_id) REFERENCES stations(station_id)
);

--Check if the Data has been successfully inserted into PostgreSQL
SELECT * FROM Stations
LIMIT 5;

SELECT * FROM Users
LIMIT 5;

SELECT * FROM Dates
LIMIT 5;

SELECT * FROM Trips
LIMIT 5;

SELECT * FROM Weather
LIMIT 5;

--Creating interesting Views
--1. Average Trip Duration by Day of Week

CREATE VIEW avg_trip_duration_by_day AS 
SELECT 
    TO_CHAR(d.date, 'Day') AS day_of_week,
    ROUND(AVG(t.trip_duration),2) AS avg_duration 
FROM Trips t 
JOIN Dates d ON t.date_id = d.date_id 
GROUP BY TO_CHAR(d.date, 'Day'), TO_CHAR(d.date, 'D')
ORDER BY TO_CHAR(d.date, 'D');

SELECT *
FROM avg_trip_duration_by_day;

--2. Trips by Station Pair (Start->End)

CREATE VIEW trips_by_station_pair AS
SELECT
    s1.station_name AS start_station,
    s2.station_name AS end_station,
    COUNT(t.trip_id) AS total_trips
FROM Trips t
JOIN Stations s1 ON t.start_station_id = s1.station_id
JOIN Stations s2 ON t.end_station_id = s2.station_id
GROUP BY s1.station_name, s2.station_name
ORDER BY total_trips DESC;

SELECT *
FROM trips_by_station_pair;

--3. Trips by User Type and Weather Condition

CREATE VIEW trip_counts_by_user_and_weather AS
SELECT
    u.user_type,
    w.tavg AS avg_temp,
    w.prcp AS precipitation,
    COUNT(t.trip_id) AS total_trips
FROM Trips t
JOIN Users u ON t.user_id = u.user_id
JOIN Weather w ON t.date_id = w.date_id
GROUP BY u.user_type, w.tavg, w.prcp
ORDER BY total_trips DESC;

SELECT *
FROM trip_counts_by_user_and_weather;

--4. Stations with the Most Frequent Users

CREATE VIEW stations_with_most_frequent_users AS
SELECT
    s.station_name,
    COUNT(DISTINCT t.user_id) AS unique_users
FROM Trips t
JOIN Stations s ON t.start_station_id = s.station_id
GROUP BY s.station_name
ORDER BY unique_users DESC;


SELECT *
FROM stations_with_most_frequent_users;

--5. Weather Impact on Trip Duration

CREATE VIEW weather_impact_on_trip_duration AS
SELECT
    w.tavg AS avg_temp,
    w.wsf2 AS wind_speed,
    ROUND(AVG(t.trip_duration),2) AS avg_trip_duration
FROM Trips t
JOIN Weather w ON t.date_id = w.date_id
GROUP BY w.tavg, w.wsf2
ORDER BY avg_trip_duration DESC;

SELECT *
FROM weather_impact_on_trip_duration;
