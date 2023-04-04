-- cleaning [dbo].['2021_08_tripdata$']
-- check for duplicates
SELECT ride_id,
	started_at,
	ended_at,
	count(*)
FROM [dbo].['2021_08_tripdata$']
GROUP BY ride_id,
	started_at,
	ended_at
HAVING count(*) > 1;

-- checking for nulls
SELECT *
FROM [dbo].['2021_08_tripdata$']
WHERE rideable_type IS NULL;

SELECT *
FROM [dbo].['2021_08_tripdata$']
WHERE started_at IS NULL;

SELECT *
FROM [dbo].['2021_08_tripdata$']
WHERE ended_at IS NULL;

SELECT *
FROM [dbo].['2021_08_tripdata$']
WHERE start_station_name IS NULL;

DELETE
FROM [dbo].['2021_08_tripdata$']
WHERE start_station_name IS NULL;

SELECT *
FROM [dbo].['2021_08_tripdata$']
WHERE start_station_id IS NULL;

SELECT *
FROM [dbo].['2021_08_tripdata$']
WHERE end_station_name IS NULL;

DELETE
FROM [dbo].['2021_08_tripdata$']
WHERE end_station_name IS NULL;

SELECT *
FROM [dbo].['2021_08_tripdata$']
WHERE start_lat IS NULL;

SELECT *
FROM [dbo].['2021_08_tripdata$']
WHERE start_lng IS NULL;

SELECT *
FROM [dbo].['2021_08_tripdata$']
WHERE end_lat IS NULL;

SELECT *
FROM [dbo].['2021_08_tripdata$']
WHERE end_lng IS NULL;

-- have a few where end long  and lat are null.  Do they carry over to the next month?
SELECT *
FROM [dbo].['2021_08_tripdata$']
WHERE member_casual IS NULL;

-- making sure all longitudes and latitudes are good
SELECT *
FROM [dbo].['2021_08_tripdata$']
WHERE len(start_lat) < 2
	OR len(start_lng) < 2
	OR len(end_lat) < 2
	OR len(end_lng) < 2;

-- making sure member_casual is good
SELECT *
FROM [dbo].['2021_08_tripdata$']
WHERE member_casual != 'member'
	AND member_casual != 'casual';

-- checking rideable_type for discrepancies
SELECT DISTINCT rideable_type
FROM [dbo].['2021_08_tripdata$'];

-- checking that ride times make sense
SELECT *
FROM [dbo].['2021_08_tripdata$']
WHERE started_at >= ended_at;

-- will remove these because a ride can not end before it begins or = 0
DELETE
FROM [dbo].['2021_08_tripdata$']
WHERE started_at >= ended_at;

-- Remove rows with NULL lat or lon.
SELECT *
FROM [dbo].['2021_08_tripdata$']
WHERE end_lng IS NULL;

SELECT *
FROM [dbo].['2021_08_tripdata$']
WHERE end_lat IS NULL;

DELETE
FROM [dbo].['2021_08_tripdata$']
WHERE end_lng IS NULL;

-- creating a view of cleaned data for use in analysis.
CREATE VIEW [2021_08_cleaned]
AS
SELECT ride_id,
	rideable_type,
	started_at,
	DATENAME(dw, started_at) AS start_day_of_week,
	ended_at,
	DATENAME(dw, ended_at) AS end_day_of_week,
	cast(ended_at - started_at AS TIME) AS ride_length,
	start_station_name,
	start_station_id,
	end_station_name,
	end_station_id,
	start_lat,
	start_lng,
	end_lat,
	end_lng,
	member_casual
FROM [dbo].['2021_08_tripdata$'];

-- added day of week and ride lenght to august 2021.
SELECT *
FROM [2021_08_cleaned];

-- cleaning [dbo].['2021_09_tripdata$']
-- check for duplicates
SELECT ride_id,
	started_at,
	ended_at,
	count(*)
FROM [dbo].['2021_09_tripdata$']
GROUP BY ride_id,
	started_at,
	ended_at
HAVING count(*) > 1;

-- checking for nulls
SELECT *
FROM [dbo].['2021_09_tripdata$']
WHERE rideable_type IS NULL;

SELECT *
FROM [dbo].['2021_09_tripdata$']
WHERE started_at IS NULL;

SELECT *
FROM [dbo].['2021_09_tripdata$']
WHERE ended_at IS NULL;

SELECT *
FROM [dbo].['2021_09_tripdata$']
WHERE start_station_name IS NULL;

DELETE
FROM [dbo].['2021_09_tripdata$']
WHERE start_station_name IS NULL;

SELECT *
FROM [dbo].['2021_09_tripdata$']
WHERE start_station_id IS NULL;

SELECT *
FROM [dbo].['2021_09_tripdata$']
WHERE end_station_name IS NULL;

DELETE
FROM [dbo].['2021_09_tripdata$']
WHERE end_station_name IS NULL;

SELECT *
FROM [dbo].['2021_09_tripdata$']
WHERE start_lat IS NULL;

SELECT *
FROM [dbo].['2021_09_tripdata$']
WHERE start_lng IS NULL;

SELECT *
FROM [dbo].['2021_09_tripdata$']
WHERE end_lat IS NULL;

SELECT *
FROM [dbo].['2021_09_tripdata$']
WHERE end_lng IS NULL;

-- NULL in both end_lat and end_long
SELECT *
FROM [dbo].['2021_09_tripdata$']
WHERE member_casual IS NULL;

-- making sure all longitudes and latitudes are good
SELECT *
FROM [dbo].['2021_09_tripdata$']
WHERE len(start_lat) < 2
	OR len(start_lng) < 2
	OR len(end_lat) < 2
	OR len(end_lng) < 2;

-- making sure member_casual is good
SELECT *
FROM [dbo].['2021_09_tripdata$']
WHERE member_casual != 'member'
	AND member_casual != 'casual';

-- checking rideable_type for discrepancies
SELECT DISTINCT rideable_type
FROM [dbo].['2021_09_tripdata$'];

-- checking that ride times make sense
SELECT *
FROM [dbo].['2021_09_tripdata$']
WHERE started_at >= ended_at;

-- will remove these because a ride can not end before it begins
DELETE
FROM [dbo].['2021_09_tripdata$']
WHERE started_at >= ended_at;

-- Remove rows with NULL lat or lon.
SELECT *
FROM [dbo].['2021_09_tripdata$']
WHERE end_lat IS NULL;

SELECT *
FROM [dbo].['2021_09_tripdata$']
WHERE end_lng IS NULL;

DELETE
FROM [dbo].['2021_09_tripdata$']
WHERE end_lat IS NULL;

-- creating a view of cleaned data for use in analysis.
CREATE VIEW [2021_09_cleaned]
AS
SELECT ride_id,
	rideable_type,
	started_at,
	DATENAME(dw, started_at) AS start_day_of_week,
	ended_at,
	DATENAME(dw, ended_at) AS end_day_of_week,
	cast(ended_at - started_at AS TIME) AS ride_length,
	start_station_name,
	start_station_id,
	end_station_name,
	end_station_id,
	start_lat,
	start_lng,
	end_lat,
	end_lng,
	member_casual
FROM [dbo].['2021_09_tripdata$'];

SELECT *
FROM dbo.[2021_09_cleaned];

-- cleaning [dbo].['2021_10_tripdata$']
-- check for duplicates
SELECT ride_id,
	started_at,
	ended_at,
	count(*)
FROM [dbo].['2021_10_tripdata$']
GROUP BY ride_id,
	started_at,
	ended_at
HAVING count(*) > 1;

-- checking for nulls
SELECT *
FROM [dbo].['2021_10_tripdata$']
WHERE rideable_type IS NULL;

SELECT *
FROM [dbo].['2021_10_tripdata$']
WHERE started_at IS NULL;

SELECT *
FROM [dbo].['2021_10_tripdata$']
WHERE ended_at IS NULL;

SELECT *
FROM [dbo].['2021_10_tripdata$']
WHERE start_station_name IS NULL;

DELETE
FROM [dbo].['2021_10_tripdata$']
WHERE start_station_name IS NULL;

SELECT *
FROM [dbo].['2021_10_tripdata$']
WHERE start_station_id IS NULL;

SELECT *
FROM [dbo].['2021_10_tripdata$']
WHERE end_station_name IS NULL;

DELETE
FROM [dbo].['2021_10_tripdata$']
WHERE end_station_name IS NULL;

SELECT *
FROM [dbo].['2021_10_tripdata$']
WHERE start_lat IS NULL;

SELECT *
FROM [dbo].['2021_10_tripdata$']
WHERE start_lng IS NULL;

SELECT *
FROM [dbo].['2021_10_tripdata$']
WHERE end_lat IS NULL;

SELECT *
FROM [dbo].['2021_10_tripdata$']
WHERE end_lng IS NULL;

-- NULL in both end_lat and end_long
SELECT *
FROM [dbo].['2021_10_tripdata$']
WHERE member_casual IS NULL;

-- making sure all longitudes and latitudes are good
SELECT *
FROM [dbo].['2021_10_tripdata$']
WHERE len(start_lat) < 2
	OR len(start_lng) < 2
	OR len(end_lat) < 2
	OR len(end_lng) < 2;

-- making sure member_casual is good
SELECT *
FROM [dbo].['2021_10_tripdata$']
WHERE member_casual != 'member'
	AND member_casual != 'casual';

-- checking rideable_type for discrepancies
SELECT DISTINCT rideable_type
FROM [dbo].['2021_10_tripdata$'];

-- checking that ride times make sense
SELECT *
FROM [dbo].['2021_10_tripdata$']
WHERE started_at >= ended_at;

-- will remove these because a ride can not end before it begins
DELETE
FROM [dbo].['2021_10_tripdata$']
WHERE started_at >= ended_at;

-- Remove rows with NULL lat or lon.
SELECT *
FROM [dbo].['2021_10_tripdata$']
WHERE end_lat IS NULL;

SELECT *
FROM [dbo].['2021_10_tripdata$']
WHERE end_lng IS NULL;

DELETE
FROM [dbo].['2021_10_tripdata$']
WHERE end_lat IS NULL;

-- creating a view of cleaned data for use in analysis.
CREATE VIEW [2021_10_cleaned]
AS
SELECT ride_id,
	rideable_type,
	started_at,
	DATENAME(dw, started_at) AS start_day_of_week,
	ended_at,
	DATENAME(dw, ended_at) AS end_day_of_week,
	cast(ended_at - started_at AS TIME) AS ride_length,
	start_station_name,
	start_station_id,
	end_station_name,
	end_station_id,
	start_lat,
	start_lng,
	end_lat,
	end_lng,
	member_casual
FROM [dbo].['2021_10_tripdata$'];

SELECT *
FROM [dbo].[2021_10_cleaned];

-- cleaning [dbo].['2021_11_tripdata$']
-- check for duplicates
SELECT ride_id,
	started_at,
	ended_at,
	count(*)
FROM [dbo].['2021_11_tripdata$']
GROUP BY ride_id,
	started_at,
	ended_at
HAVING count(*) > 1;

-- checking for nulls
SELECT *
FROM [dbo].['2021_11_tripdata$']
WHERE rideable_type IS NULL;

SELECT *
FROM [dbo].['2021_11_tripdata$']
WHERE started_at IS NULL;

SELECT *
FROM [dbo].['2021_11_tripdata$']
WHERE ended_at IS NULL;

SELECT *
FROM [dbo].['2021_11_tripdata$']
WHERE start_station_name IS NULL;

DELETE
FROM [dbo].['2021_11_tripdata$']
WHERE start_station_name IS NULL;

SELECT *
FROM [dbo].['2021_11_tripdata$']
WHERE start_station_id IS NULL;

DELETE
FROM [dbo].['2021_11_tripdata$']
WHERE start_station_id IS NULL

SELECT *
FROM [dbo].['2021_11_tripdata$']
WHERE end_station_name IS NULL;

DELETE
FROM [dbo].['2021_11_tripdata$']
WHERE end_station_name IS NULL;

SELECT *
FROM [dbo].['2021_11_tripdata$']
WHERE start_lat IS NULL;

SELECT *
FROM [dbo].['2021_11_tripdata$']
WHERE start_lng IS NULL;

SELECT *
FROM [dbo].['2021_11_tripdata$']
WHERE end_lat IS NULL;

SELECT *
FROM [dbo].['2021_11_tripdata$']
WHERE end_lng IS NULL;

-- NULL in both end_lat and end_long
SELECT *
FROM [dbo].['2021_11_tripdata$']
WHERE member_casual IS NULL;

-- making sure all longitudes and latitudes are good
SELECT *
FROM [dbo].['2021_11_tripdata$']
WHERE len(start_lat) < 2
	OR len(start_lng) < 2
	OR len(end_lat) < 2
	OR len(end_lng) < 2;

-- making sure member_casual is good
SELECT *
FROM [dbo].['2021_11_tripdata$']
WHERE member_casual != 'member'
	AND member_casual != 'casual';

-- checking rideable_type for discrepancies
SELECT DISTINCT rideable_type
FROM [dbo].['2021_11_tripdata$'];

-- checking that ride times make sense
SELECT *
FROM [dbo].['2021_11_tripdata$']
WHERE started_at >= ended_at;

-- will remove these because a ride can not end before it begins
DELETE
FROM [dbo].['2021_11_tripdata$']
WHERE started_at >= ended_at;

-- Remove rows with NULL lat or lon.
SELECT *
FROM [dbo].['2021_11_tripdata$']
WHERE end_lat IS NULL;

SELECT *
FROM [dbo].['2021_11_tripdata$']
WHERE end_lng IS NULL;

DELETE
FROM [dbo].['2021_11_tripdata$']
WHERE end_lat IS NULL;

-- creating a view of cleaned data for use in analysis.
CREATE VIEW [2021_11_cleaned]
AS
SELECT ride_id,
	rideable_type,
	started_at,
	DATENAME(dw, started_at) AS start_day_of_week,
	ended_at,
	DATENAME(dw, ended_at) AS end_day_of_week,
	cast(ended_at - started_at AS TIME) AS ride_length,
	start_station_name,
	start_station_id,
	end_station_name,
	end_station_id,
	start_lat,
	start_lng,
	end_lat,
	end_lng,
	member_casual
FROM [dbo].['2021_11_tripdata$'];

SELECT *
FROM [dbo].[2021_11_cleaned];

-- cleaning [dbo].['2021_12_tripdata$']
-- check for duplicates
SELECT ride_id,
	started_at,
	ended_at,
	count(*)
FROM [dbo].['2021_12_tripdata$']
GROUP BY ride_id,
	started_at,
	ended_at
HAVING count(*) > 1;

-- checking for nulls
SELECT *
FROM [dbo].['2021_12_tripdata$']
WHERE rideable_type IS NULL;

SELECT *
FROM [dbo].['2021_12_tripdata$']
WHERE started_at IS NULL;

SELECT *
FROM [dbo].['2021_12_tripdata$']
WHERE ended_at IS NULL;

SELECT *
FROM [dbo].['2021_12_tripdata$']
WHERE start_station_name IS NULL;

DELETE
FROM [dbo].['2021_12_tripdata$']
WHERE start_station_name IS NULL;

SELECT *
FROM [dbo].['2021_12_tripdata$']
WHERE start_station_id IS NULL;

SELECT *
FROM [dbo].['2021_12_tripdata$']
WHERE end_station_name IS NULL;

DELETE
FROM [dbo].['2021_12_tripdata$']
WHERE end_station_name IS NULL;

SELECT *
FROM [dbo].['2021_12_tripdata$']
WHERE start_lat IS NULL;

SELECT *
FROM [dbo].['2021_12_tripdata$']
WHERE start_lng IS NULL;

SELECT *
FROM [dbo].['2021_12_tripdata$']
WHERE end_lat IS NULL;

SELECT *
FROM [dbo].['2021_12_tripdata$']
WHERE end_lng IS NULL;

-- NULL in both end_lat and end_long
SELECT *
FROM [dbo].['2021_12_tripdata$']
WHERE member_casual IS NULL;

-- making sure all longitudes and latitudes are good
SELECT *
FROM [dbo].['2021_12_tripdata$']
WHERE len(start_lat) < 2
	OR len(start_lng) < 2
	OR len(end_lat) < 2
	OR len(end_lng) < 2;

-- making sure member_casual is good
SELECT *
FROM [dbo].['2021_12_tripdata$']
WHERE member_casual != 'member'
	AND member_casual != 'casual';

-- checking rideable_type for discrepancies
SELECT DISTINCT rideable_type
FROM [dbo].['2021_12_tripdata$'];

-- checking that ride times make sense
SELECT *
FROM [dbo].['2021_12_tripdata$']
WHERE started_at >= ended_at;

-- will remove these because a ride can not end before it begins
DELETE
FROM [dbo].['2021_12_tripdata$']
WHERE started_at >= ended_at;

-- Remove rows with NULL lat or lon.
SELECT *
FROM [dbo].['2021_12_tripdata$']
WHERE end_lat IS NULL;

SELECT *
FROM [dbo].['2021_12_tripdata$']
WHERE end_lng IS NULL;

DELETE
FROM [dbo].['2021_12_tripdata$']
WHERE end_lat IS NULL;

-- creating a view of cleaned data for use in analysis.
CREATE VIEW [2021_12_cleaned]
AS
SELECT ride_id,
	rideable_type,
	started_at,
	DATENAME(dw, started_at) AS start_day_of_week,
	ended_at,
	DATENAME(dw, ended_at) AS end_day_of_week,
	cast(ended_at - started_at AS TIME) AS ride_length,
	start_station_name,
	start_station_id,
	end_station_name,
	end_station_id,
	start_lat,
	start_lng,
	end_lat,
	end_lng,
	member_casual
FROM [dbo].['2021_12_tripdata$'];

SELECT *
FROM [dbo].[2021_12_cleaned];

-- cleaning [dbo].['2022_01_tripdata$']
-- check for duplicates
SELECT ride_id,
	started_at,
	ended_at,
	count(*)
FROM [dbo].['2022_01_tripdata$']
GROUP BY ride_id,
	started_at,
	ended_at
HAVING count(*) > 1;

-- checking for nulls
SELECT *
FROM [dbo].['2022_01_tripdata$']
WHERE rideable_type IS NULL;

SELECT *
FROM [dbo].['2022_01_tripdata$']
WHERE started_at IS NULL;

SELECT *
FROM [dbo].['2022_01_tripdata$']
WHERE ended_at IS NULL;

SELECT *
FROM [dbo].['2022_01_tripdata$']
WHERE start_station_name IS NULL;

DELETE
FROM [dbo].['2022_01_tripdata$']
WHERE start_station_name IS NULL;

SELECT *
FROM [dbo].['2022_01_tripdata$']
WHERE start_station_id IS NULL;

SELECT *
FROM [dbo].['2022_01_tripdata$']
WHERE end_station_name IS NULL;

DELETE
FROM [dbo].['2022_01_tripdata$']
WHERE end_station_name IS NULL;

SELECT *
FROM [dbo].['2022_01_tripdata$']
WHERE start_lat IS NULL;

SELECT *
FROM [dbo].['2022_01_tripdata$']
WHERE start_lng IS NULL;

SELECT *
FROM [dbo].['2022_01_tripdata$']
WHERE end_lat IS NULL;

SELECT *
FROM [dbo].['2022_01_tripdata$']
WHERE end_lng IS NULL;

-- NULL in both end_lat and end_long
SELECT *
FROM [dbo].['2022_01_tripdata$']
WHERE member_casual IS NULL;

-- making sure all longitudes and latitudes are good
SELECT *
FROM [dbo].['2022_01_tripdata$']
WHERE len(start_lat) < 2
	OR len(start_lng) < 2
	OR len(end_lat) < 2
	OR len(end_lng) < 2;

-- making sure member_casual is good
SELECT *
FROM [dbo].['2022_01_tripdata$']
WHERE member_casual != 'member'
	AND member_casual != 'casual';

-- checking rideable_type for discrepancies
SELECT DISTINCT rideable_type
FROM [dbo].['2022_01_tripdata$'];

-- checking that ride times make sense
SELECT *
FROM [dbo].['2022_01_tripdata$']
WHERE started_at >= ended_at;

-- will remove these because a ride can not end before it begins
DELETE
FROM [dbo].['2022_01_tripdata$']
WHERE started_at >= ended_at;

-- Remove rows with NULL lat or lon.
SELECT *
FROM [dbo].['2022_01_tripdata$']
WHERE end_lat IS NULL;

SELECT *
FROM [dbo].['2022_01_tripdata$']
WHERE end_lng IS NULL;

DELETE
FROM [dbo].['2022_01_tripdata$']
WHERE end_lat IS NULL;

-- creating a view of cleaned data for use in analysis.
CREATE VIEW [2022_01_cleaned]
AS
SELECT ride_id,
	rideable_type,
	started_at,
	DATENAME(dw, started_at) AS start_day_of_week,
	ended_at,
	DATENAME(dw, ended_at) AS end_day_of_week,
	cast(ended_at - started_at AS TIME) AS ride_length,
	start_station_name,
	start_station_id,
	end_station_name,
	end_station_id,
	start_lat,
	start_lng,
	end_lat,
	end_lng,
	member_casual
FROM [dbo].['2022_01_tripdata$'];

SELECT *
FROM [dbo].[2022_01_cleaned];

-- cleaning [dbo].['2022_02_tripdata$']
-- check for duplicates
SELECT ride_id,
	started_at,
	ended_at,
	count(*)
FROM [dbo].['2022_02_tripdata$']
GROUP BY ride_id,
	started_at,
	ended_at
HAVING count(*) > 1;

-- checking for nulls
SELECT *
FROM [dbo].['2022_02_tripdata$']
WHERE rideable_type IS NULL;

SELECT *
FROM [dbo].['2022_02_tripdata$']
WHERE started_at IS NULL;

SELECT *
FROM [dbo].['2022_02_tripdata$']
WHERE ended_at IS NULL;

SELECT *
FROM [dbo].['2022_02_tripdata$']
WHERE start_station_name IS NULL;

DELETE
FROM [dbo].['2022_02_tripdata$']
WHERE start_station_name IS NULL;

SELECT *
FROM [dbo].['2022_02_tripdata$']
WHERE start_station_id IS NULL;

SELECT *
FROM [dbo].['2022_02_tripdata$']
WHERE end_station_name IS NULL;

DELETE
FROM [dbo].['2022_02_tripdata$']
WHERE end_station_name IS NULL;

SELECT *
FROM [dbo].['2022_02_tripdata$']
WHERE start_lat IS NULL;

SELECT *
FROM [dbo].['2022_02_tripdata$']
WHERE start_lng IS NULL;

SELECT *
FROM [dbo].['2022_02_tripdata$']
WHERE end_lat IS NULL;

SELECT *
FROM [dbo].['2022_02_tripdata$']
WHERE end_lng IS NULL;

-- NULL in both end_lat and end_long
SELECT *
FROM [dbo].['2022_02_tripdata$']
WHERE member_casual IS NULL;

-- making sure all longitudes and latitudes are good
SELECT *
FROM [dbo].['2022_02_tripdata$']
WHERE len(start_lat) < 2
	OR len(start_lng) < 2
	OR len(end_lat) < 2
	OR len(end_lng) < 2;

-- making sure member_casual is good
SELECT *
FROM [dbo].['2022_02_tripdata$']
WHERE member_casual != 'member'
	AND member_casual != 'casual';

-- checking rideable_type for discrepancies
SELECT DISTINCT rideable_type
FROM [dbo].['2022_01_tripdata$'];

-- checking that ride times make sense
SELECT *
FROM [dbo].['2022_02_tripdata$']
WHERE started_at >= ended_at;

-- will remove these because a ride can not end before it begins
DELETE
FROM [dbo].['2022_02_tripdata$']
WHERE started_at >= ended_at;

-- Remove rows with NULL lat or lon.
SELECT *
FROM [dbo].['2022_02_tripdata$']
WHERE end_lat IS NULL;

SELECT *
FROM [dbo].['2022_02_tripdata$']
WHERE end_lng IS NULL;

DELETE
FROM [dbo].['2022_02_tripdata$']
WHERE end_lat IS NULL;

-- creating a view of cleaned data for use in analysis.
CREATE VIEW [2022_02_cleaned]
AS
SELECT ride_id,
	rideable_type,
	started_at,
	DATENAME(dw, started_at) AS start_day_of_week,
	ended_at,
	DATENAME(dw, ended_at) AS end_day_of_week,
	cast(ended_at - started_at AS TIME) AS ride_length,
	start_station_name,
	start_station_id,
	end_station_name,
	end_station_id,
	start_lat,
	start_lng,
	end_lat,
	end_lng,
	member_casual
FROM [dbo].['2022_02_tripdata$'];

SELECT *
FROM [dbo].[2022_02_cleaned];

-- cleaning [dbo].['2022_03_tripdata$']
-- check for duplicates
SELECT ride_id,
	started_at,
	ended_at,
	count(*)
FROM [dbo].['2022_03_tripdata$']
GROUP BY ride_id,
	started_at,
	ended_at
HAVING count(*) > 1;

-- checking for nulls
SELECT *
FROM [dbo].['2022_03_tripdata$']
WHERE rideable_type IS NULL;

SELECT *
FROM [dbo].['2022_03_tripdata$']
WHERE started_at IS NULL;

SELECT *
FROM [dbo].['2022_03_tripdata$']
WHERE ended_at IS NULL;

SELECT *
FROM [dbo].['2022_03_tripdata$']
WHERE start_station_name IS NULL;

DELETE
FROM [dbo].['2022_03_tripdata$']
WHERE start_station_name IS NULL;

SELECT *
FROM [dbo].['2022_03_tripdata$']
WHERE start_station_id IS NULL;

SELECT *
FROM [dbo].['2022_03_tripdata$']
WHERE end_station_name IS NULL;

DELETE
FROM [dbo].['2022_03_tripdata$']
WHERE end_station_name IS NULL;

SELECT *
FROM [dbo].['2022_03_tripdata$']
WHERE start_lat IS NULL;

SELECT *
FROM [dbo].['2022_03_tripdata$']
WHERE start_lng IS NULL;

SELECT *
FROM [dbo].['2022_03_tripdata$']
WHERE end_lat IS NULL;

SELECT *
FROM [dbo].['2022_03_tripdata$']
WHERE end_lng IS NULL;

-- NULL in both end_lat and end_long
SELECT *
FROM [dbo].['2022_03_tripdata$']
WHERE member_casual IS NULL;

-- making sure all longitudes and latitudes are good
SELECT *
FROM [dbo].['2022_03_tripdata$']
WHERE len(start_lat) < 2
	OR len(start_lng) < 2
	OR len(end_lat) < 2
	OR len(end_lng) < 2;

-- making sure member_casual is good
SELECT *
FROM [dbo].['2022_03_tripdata$']
WHERE member_casual != 'member'
	AND member_casual != 'casual';

-- checking rideable_type for discrepancies
SELECT DISTINCT rideable_type
FROM [dbo].['2022_03_tripdata$'];

-- checking that ride times make sense
SELECT *
FROM [dbo].['2022_03_tripdata$']
WHERE started_at >= ended_at;

-- will remove these because a ride can not end before it begins
DELETE
FROM [dbo].['2022_03_tripdata$']
WHERE started_at >= ended_at;

-- Remove rows with NULL lat or lon.
SELECT *
FROM [dbo].['2022_03_tripdata$']
WHERE end_lat IS NULL;

SELECT *
FROM [dbo].['2022_03_tripdata$']
WHERE end_lng IS NULL;

DELETE
FROM [dbo].['2022_03_tripdata$']
WHERE end_lat IS NULL;

-- creating a view of cleaned data for use in analysis.
CREATE VIEW [2022_03_cleaned]
AS
SELECT ride_id,
	rideable_type,
	started_at,
	DATENAME(dw, started_at) AS start_day_of_week,
	ended_at,
	DATENAME(dw, ended_at) AS end_day_of_week,
	cast(ended_at - started_at AS TIME) AS ride_length,
	start_station_name,
	start_station_id,
	end_station_name,
	end_station_id,
	start_lat,
	start_lng,
	end_lat,
	end_lng,
	member_casual
FROM [dbo].['2022_03_tripdata$'];

SELECT *
FROM [dbo].[2022_03_cleaned];

-- cleaning [dbo].['2022_04_tripdata$']
-- check for duplicates
SELECT ride_id,
	started_at,
	ended_at,
	count(*)
FROM [dbo].['2022_04_tripdata$']
GROUP BY ride_id,
	started_at,
	ended_at
HAVING count(*) > 1;

-- checking for nulls
SELECT *
FROM [dbo].['2022_04_tripdata$']
WHERE rideable_type IS NULL;

SELECT *
FROM [dbo].['2022_04_tripdata$']
WHERE started_at IS NULL;

SELECT *
FROM [dbo].['2022_04_tripdata$']
WHERE ended_at IS NULL;

SELECT *
FROM [dbo].['2022_04_tripdata$']
WHERE start_station_name IS NULL;

DELETE
FROM [dbo].['2022_04_tripdata$']
WHERE start_station_name IS NULL;

SELECT *
FROM [dbo].['2022_04_tripdata$']
WHERE start_station_id IS NULL;

DELETE
FROM [dbo].['2022_04_tripdata$']
WHERE start_station_id IS NULL;

SELECT *
FROM [dbo].['2022_04_tripdata$']
WHERE end_station_name IS NULL;

DELETE
FROM [dbo].['2022_04_tripdata$']
WHERE end_station_name IS NULL;

SELECT *
FROM [dbo].['2022_04_tripdata$']
WHERE start_lat IS NULL;

SELECT *
FROM [dbo].['2022_04_tripdata$']
WHERE start_lng IS NULL;

SELECT *
FROM [dbo].['2022_04_tripdata$']
WHERE end_lat IS NULL;

SELECT *
FROM [dbo].['2022_04_tripdata$']
WHERE end_lng IS NULL;

-- NULL in both end_lat and end_long
SELECT *
FROM [dbo].['2022_04_tripdata$']
WHERE member_casual IS NULL;

-- making sure all longitudes and latitudes are good
SELECT *
FROM [dbo].['2022_04_tripdata$']
WHERE len(start_lat) < 2
	OR len(start_lng) < 2
	OR len(end_lat) < 2
	OR len(end_lng) < 2;

-- making sure member_casual is good
SELECT *
FROM [dbo].['2022_04_tripdata$']
WHERE member_casual != 'member'
	AND member_casual != 'casual';

-- checking rideable_type for discrepancies
SELECT DISTINCT rideable_type
FROM [dbo].['2022_04_tripdata$'];

-- checking that ride times make sense
SELECT *
FROM [dbo].['2022_04_tripdata$']
WHERE started_at >= ended_at;

-- will remove these because a ride can not end before it begins
DELETE
FROM [dbo].['2022_04_tripdata$']
WHERE started_at >= ended_at;

-- Remove rows with NULL lat or lon.
SELECT *
FROM [dbo].['2022_04_tripdata$']
WHERE end_lat IS NULL;

SELECT *
FROM [dbo].['2022_04_tripdata$']
WHERE end_lng IS NULL;

DELETE
FROM [dbo].['2022_04_tripdata$']
WHERE end_lat IS NULL;

-- creating a view of cleaned data for use in analysis.
CREATE VIEW [2022_04_cleaned]
AS
SELECT ride_id,
	rideable_type,
	started_at,
	DATENAME(dw, started_at) AS start_day_of_week,
	ended_at,
	DATENAME(dw, ended_at) AS end_day_of_week,
	cast(ended_at - started_at AS TIME) AS ride_length,
	start_station_name,
	start_station_id,
	end_station_name,
	end_station_id,
	start_lat,
	start_lng,
	end_lat,
	end_lng,
	member_casual
FROM [dbo].['2022_04_tripdata$'];

SELECT *
FROM [dbo].[2022_04_cleaned];

-- cleaning [dbo].['2022_05_tripdata$']
-- check for duplicates
SELECT ride_id,
	started_at,
	ended_at,
	count(*)
FROM [dbo].['2022_05_tripdata$']
GROUP BY ride_id,
	started_at,
	ended_at
HAVING count(*) > 1;

-- checking for nulls
SELECT *
FROM [dbo].['2022_05_tripdata$']
WHERE rideable_type IS NULL;

SELECT *
FROM [dbo].['2022_05_tripdata$']
WHERE started_at IS NULL;

SELECT *
FROM [dbo].['2022_05_tripdata$']
WHERE ended_at IS NULL;

SELECT *
FROM [dbo].['2022_05_tripdata$']
WHERE start_station_name IS NULL;

DELETE
FROM [dbo].['2022_05_tripdata$']
WHERE start_station_name IS NULL;

SELECT *
FROM [dbo].['2022_05_tripdata$']
WHERE start_station_id IS NULL;

SELECT *
FROM [dbo].['2022_05_tripdata$']
WHERE end_station_name IS NULL;

DELETE
FROM [dbo].['2022_05_tripdata$']
WHERE end_station_name IS NULL;

SELECT *
FROM [dbo].['2022_05_tripdata$']
WHERE start_lat IS NULL;

SELECT *
FROM [dbo].['2022_05_tripdata$']
WHERE start_lng IS NULL;

SELECT *
FROM [dbo].['2022_05_tripdata$']
WHERE end_lat IS NULL;

SELECT *
FROM [dbo].['2022_05_tripdata$']
WHERE end_lng IS NULL;

-- NULL in both end_lat and end_long
SELECT *
FROM [dbo].['2022_05_tripdata$']
WHERE member_casual IS NULL;

-- making sure all longitudes and latitudes are good
SELECT *
FROM [dbo].['2022_05_tripdata$']
WHERE len(start_lat) < 2
	OR len(start_lng) < 2
	OR len(end_lat) < 2
	OR len(end_lng) < 2;

-- making sure member_casual is good
SELECT *
FROM [dbo].['2022_05_tripdata$']
WHERE member_casual != 'member'
	AND member_casual != 'casual';

-- checking rideable_type for discrepancies
SELECT DISTINCT rideable_type
FROM [dbo].['2022_05_tripdata$'];

-- checking that ride times make sense
SELECT *
FROM [dbo].['2022_05_tripdata$']
WHERE started_at >= ended_at;

-- will remove these because a ride can not end before it begins
DELETE
FROM [dbo].['2022_05_tripdata$']
WHERE started_at >= ended_at;

-- Remove rows with NULL lat or lon.
SELECT *
FROM [dbo].['2022_05_tripdata$']
WHERE end_lat IS NULL;

SELECT *
FROM [dbo].['2022_05_tripdata$']
WHERE end_lng IS NULL;

DELETE
FROM [dbo].['2022_05_tripdata$']
WHERE end_lat IS NULL;

-- creating a view of cleaned data for use in analysis.
CREATE VIEW [2022_05_cleaned]
AS
SELECT ride_id,
	rideable_type,
	started_at,
	DATENAME(dw, started_at) AS start_day_of_week,
	ended_at,
	DATENAME(dw, ended_at) AS end_day_of_week,
	cast(ended_at - started_at AS TIME) AS ride_length,
	start_station_name,
	start_station_id,
	end_station_name,
	end_station_id,
	start_lat,
	start_lng,
	end_lat,
	end_lng,
	member_casual
FROM [dbo].['2022_05_tripdata$'];

SELECT *
FROM [dbo].[2022_05_cleaned];

-- cleaning [dbo].['2022_06_tripdata$']
-- check for duplicates
SELECT ride_id,
	started_at,
	ended_at,
	count(*)
FROM [dbo].['2022_06_tripdata$']
GROUP BY ride_id,
	started_at,
	ended_at
HAVING count(*) > 1;

-- checking for nulls
SELECT *
FROM [dbo].['2022_06_tripdata$']
WHERE rideable_type IS NULL;

SELECT *
FROM [dbo].['2022_06_tripdata$']
WHERE started_at IS NULL;

SELECT *
FROM [dbo].['2022_06_tripdata$']
WHERE ended_at IS NULL;

SELECT *
FROM [dbo].['2022_06_tripdata$']
WHERE start_station_name IS NULL;

DELETE
FROM [dbo].['2022_06_tripdata$']
WHERE start_station_name IS NULL;

SELECT *
FROM [dbo].['2022_06_tripdata$']
WHERE start_station_id IS NULL;

SELECT *
FROM [dbo].['2022_06_tripdata$']
WHERE end_station_name IS NULL;

DELETE
FROM [dbo].['2022_06_tripdata$']
WHERE end_station_name IS NULL;

SELECT *
FROM [dbo].['2022_06_tripdata$']
WHERE start_lat IS NULL;

SELECT *
FROM [dbo].['2022_06_tripdata$']
WHERE start_lng IS NULL;

SELECT *
FROM [dbo].['2022_06_tripdata$']
WHERE end_lat IS NULL;

SELECT *
FROM [dbo].['2022_06_tripdata$']
WHERE end_lng IS NULL;

-- NULL in both end_lat and end_long
SELECT *
FROM [dbo].['2022_06_tripdata$']
WHERE member_casual IS NULL;

-- making sure all longitudes and latitudes are good
SELECT *
FROM [dbo].['2022_06_tripdata$']
WHERE len(start_lat) < 2
	OR len(start_lng) < 2
	OR len(end_lat) < 2
	OR len(end_lng) < 2;

-- making sure member_casual is good
SELECT *
FROM [dbo].['2022_06_tripdata$']
WHERE member_casual != 'member'
	AND member_casual != 'casual';

-- checking rideable_type for discrepancies
SELECT DISTINCT rideable_type
FROM [dbo].['2022_06_tripdata$'];

-- checking that ride times make sense
SELECT *
FROM [dbo].['2022_06_tripdata$']
WHERE started_at >= ended_at;

-- will remove these because a ride can not end before it begins
DELETE
FROM [dbo].['2022_06_tripdata$']
WHERE started_at >= ended_at;

-- Remove rows with NULL lat or lon.
SELECT *
FROM [dbo].['2022_06_tripdata$']
WHERE end_lat IS NULL;

SELECT *
FROM [dbo].['2022_06_tripdata$']
WHERE end_lng IS NULL;

DELETE
FROM [dbo].['2022_06_tripdata$']
WHERE end_lat IS NULL;

-- creating a view of cleaned data for use in analysis.
CREATE VIEW [2022_06_cleaned]
AS
SELECT ride_id,
	rideable_type,
	started_at,
	DATENAME(dw, started_at) AS start_day_of_week,
	ended_at,
	DATENAME(dw, ended_at) AS end_day_of_week,
	cast(ended_at - started_at AS TIME) AS ride_length,
	start_station_name,
	start_station_id,
	end_station_name,
	end_station_id,
	start_lat,
	start_lng,
	end_lat,
	end_lng,
	member_casual
FROM [dbo].['2022_06_tripdata$'];

SELECT *
FROM [dbo].[2022_06_cleaned];

-- cleaning [dbo].['2022_07_tripdata$']
-- check for duplicates
SELECT ride_id,
	started_at,
	ended_at,
	count(*)
FROM [dbo].['2022_07_tripdata$']
GROUP BY ride_id,
	started_at,
	ended_at
HAVING count(*) > 1;

-- checking for nulls
SELECT *
FROM [dbo].['2022_07_tripdata$']
WHERE rideable_type IS NULL;

SELECT *
FROM [dbo].['2022_07_tripdata$']
WHERE started_at IS NULL;

SELECT *
FROM [dbo].['2022_07_tripdata$']
WHERE ended_at IS NULL;

SELECT *
FROM [dbo].['2022_07_tripdata$']
WHERE start_station_name IS NULL;

DELETE
FROM [dbo].['2022_07_tripdata$']
WHERE start_station_name IS NULL;

SELECT *
FROM [dbo].['2022_07_tripdata$']
WHERE start_station_id IS NULL;

DELETE
FROM [dbo].['2022_07_tripdata$']
WHERE start_station_id IS NULL;

SELECT *
FROM [dbo].['2022_07_tripdata$']
WHERE end_station_name IS NULL;

DELETE
FROM [dbo].['2022_07_tripdata$']
WHERE end_station_name IS NULL;

SELECT *
FROM [dbo].['2022_07_tripdata$']
WHERE start_lat IS NULL;

SELECT *
FROM [dbo].['2022_07_tripdata$']
WHERE start_lng IS NULL;

SELECT *
FROM [dbo].['2022_07_tripdata$']
WHERE end_lat IS NULL;

SELECT *
FROM [dbo].['2022_07_tripdata$']
WHERE end_lng IS NULL;

-- NULL in both end_lat and end_long
SELECT *
FROM [dbo].['2022_07_tripdata$']
WHERE member_casual IS NULL;

-- making sure all longitudes and latitudes are good
SELECT *
FROM [dbo].['2022_07_tripdata$']
WHERE len(start_lat) < 2
	OR len(start_lng) < 2
	OR len(end_lat) < 2
	OR len(end_lng) < 2;

-- making sure member_casual is good
SELECT *
FROM [dbo].['2022_07_tripdata$']
WHERE member_casual != 'member'
	AND member_casual != 'casual';

-- checking rideable_type for discrepancies
SELECT DISTINCT rideable_type
FROM [dbo].['2022_07_tripdata$'];

-- checking that ride times make sense
SELECT *
FROM [dbo].['2022_07_tripdata$']
WHERE started_at >= ended_at;

-- will remove these because a ride can not end before it begins
DELETE
FROM [dbo].['2022_07_tripdata$']
WHERE started_at >= ended_at;

-- Remove rows with NULL lat or lon.
SELECT *
FROM [dbo].['2022_07_tripdata$']
WHERE end_lat IS NULL;

SELECT *
FROM [dbo].['2022_07_tripdata$']
WHERE end_lng IS NULL;

DELETE
FROM [dbo].['2022_07_tripdata$']
WHERE end_lat IS NULL;

-- creating a view of cleaned data for use in analysis.
CREATE VIEW [2022_07_cleaned]
AS
SELECT ride_id,
	rideable_type,
	started_at,
	DATENAME(dw, started_at) AS start_day_of_week,
	ended_at,
	DATENAME(dw, ended_at) AS end_day_of_week,
	cast(ended_at - started_at AS TIME) AS ride_length,
	start_station_name,
	start_station_id,
	end_station_name,
	end_station_id,
	start_lat,
	start_lng,
	end_lat,
	end_lng,
	member_casual
FROM [dbo].['2022_07_tripdata$'];

SELECT *
FROM [dbo].[2022_07_cleaned];