-- merge all months into one table    
CREATE VIEW ride_data
AS
SELECT ride_id,
	rideable_type,
	started_at,
	start_day_of_week,
	ended_at,
	end_day_of_week,
	ride_length,
	start_station_name,
	start_station_id,
	end_station_name,
	end_station_id,
	start_lat,
	start_lng,
	end_lat,
	end_lng,
	member_casual
FROM [2021_08_cleaned]

UNION

SELECT ride_id,
	rideable_type,
	started_at,
	start_day_of_week,
	ended_at,
	end_day_of_week,
	ride_length,
	start_station_name,
	start_station_id,
	end_station_name,
	end_station_id,
	start_lat,
	start_lng,
	end_lat,
	end_lng,
	member_casual
FROM [2021_09_cleaned]

UNION

SELECT ride_id,
	rideable_type,
	started_at,
	start_day_of_week,
	ended_at,
	end_day_of_week,
	ride_length,
	start_station_name,
	start_station_id,
	end_station_name,
	end_station_id,
	start_lat,
	start_lng,
	end_lat,
	end_lng,
	member_casual
FROM [2021_10_cleaned]

UNION

SELECT ride_id,
	rideable_type,
	started_at,
	start_day_of_week,
	ended_at,
	end_day_of_week,
	ride_length,
	start_station_name,
	start_station_id,
	end_station_name,
	end_station_id,
	start_lat,
	start_lng,
	end_lat,
	end_lng,
	member_casual
FROM [2021_11_cleaned]

UNION

SELECT ride_id,
	rideable_type,
	started_at,
	start_day_of_week,
	ended_at,
	end_day_of_week,
	ride_length,
	start_station_name,
	start_station_id,
	end_station_name,
	end_station_id,
	start_lat,
	start_lng,
	end_lat,
	end_lng,
	member_casual
FROM [2021_12_cleaned]

UNION

SELECT ride_id,
	rideable_type,
	started_at,
	start_day_of_week,
	ended_at,
	end_day_of_week,
	ride_length,
	start_station_name,
	start_station_id,
	end_station_name,
	end_station_id,
	start_lat,
	start_lng,
	end_lat,
	end_lng,
	member_casual
FROM [2022_01_cleaned]

UNION

SELECT ride_id,
	rideable_type,
	started_at,
	start_day_of_week,
	ended_at,
	end_day_of_week,
	ride_length,
	start_station_name,
	start_station_id,
	end_station_name,
	end_station_id,
	start_lat,
	start_lng,
	end_lat,
	end_lng,
	member_casual
FROM [2022_02_cleaned]

UNION

SELECT ride_id,
	rideable_type,
	started_at,
	start_day_of_week,
	ended_at,
	end_day_of_week,
	ride_length,
	start_station_name,
	start_station_id,
	end_station_name,
	end_station_id,
	start_lat,
	start_lng,
	end_lat,
	end_lng,
	member_casual
FROM [2022_03_cleaned]

UNION

SELECT ride_id,
	rideable_type,
	started_at,
	start_day_of_week,
	ended_at,
	end_day_of_week,
	ride_length,
	start_station_name,
	start_station_id,
	end_station_name,
	end_station_id,
	start_lat,
	start_lng,
	end_lat,
	end_lng,
	member_casual
FROM [2022_04_cleaned]

UNION

SELECT ride_id,
	rideable_type,
	started_at,
	start_day_of_week,
	ended_at,
	end_day_of_week,
	ride_length,
	start_station_name,
	start_station_id,
	end_station_name,
	end_station_id,
	start_lat,
	start_lng,
	end_lat,
	end_lng,
	member_casual
FROM [2022_05_cleaned]

UNION

SELECT ride_id,
	rideable_type,
	started_at,
	start_day_of_week,
	ended_at,
	end_day_of_week,
	ride_length,
	start_station_name,
	start_station_id,
	end_station_name,
	end_station_id,
	start_lat,
	start_lng,
	end_lat,
	end_lng,
	member_casual
FROM [2022_06_cleaned]

UNION

SELECT ride_id,
	rideable_type,
	started_at,
	start_day_of_week,
	ended_at,
	end_day_of_week,
	ride_length,
	start_station_name,
	start_station_id,
	end_station_name,
	end_station_id,
	start_lat,
	start_lng,
	end_lat,
	end_lng,
	member_casual
FROM [2022_07_cleaned];

-- Fix lat and long(Since there are many slightly different coordinates for station_id's, I created unique coordinates using this query.)
CREATE VIEW [geography]
AS
SELECT station_id,
	latitude,
	longitude
FROM (
	SELECT ROW_NUMBER() OVER (
			PARTITION BY start_station_id ORDER BY start_station_id
			) AS row_num,
		start_station_id AS station_id,
		start_lat AS latitude,
		start_lng AS longitude
	FROM (
		SELECT DISTINCT t1.start_station_id,
			t1.start_lat,
			t1.start_lng,
			t2.end_station_id
		FROM [ride_data] t1
		INNER JOIN [ride_data] t2
			ON t1.start_station_id = t2.end_station_id
		) t3
	) t4
WHERE row_num = 1;

-- Rides by Day of Week/Ride Percentage
SELECT DISTINCT start_day_of_week,
	member_casual,
	COUNT(ride_id) OVER (
		PARTITION BY start_day_of_week,
		member_casual
		) ride_totals
FROM [ride_data];

-- Average Ride Length 
SELECT DISTINCT member_casual,
	start_day_of_week,
	AVG(DATEDIFF(MINUTE, started_at, ended_at)) OVER (
		PARTITION BY start_day_of_week,
		member_casual
		) AS avg_ride_length
FROM [ride_data]
ORDER BY start_day_of_week,
	member_casual;

-- Start Time of Day
SELECT COUNT(ride_id) ride_count,
	start_day_of_week,
	member_casual,
	DATEPART(hour, started_at) start_time
FROM [ride_data]
GROUP BY start_day_of_week,
	DATEPART(hour, started_at),
	member_casual
ORDER BY start_day_of_week,
	start_time,
	member_casual;

-- Top 20 Stations started_at 
SELECT *
FROM (
	SELECT *,
		DENSE_RANK() OVER (
			ORDER BY total_rides_sum DESC
			) rides_sum_rank
	FROM (
		SELECT start_station_id,
			start_station_name,
			start_day_of_week,
			start_hour,
			latitude,
			longitude,
			member_casual,
			total_rides,
			SUM(total_rides) OVER (
				PARTITION BY start_station_id,
				start_station_name
				) total_rides_sum
		FROM (
			SELECT DISTINCT rd.start_station_id,
				start_station_name,
				start_day_of_week,
				DATEPART(hour, started_at) start_hour,
				latitude,
				longitude,
				member_casual,
				COUNT(ride_id) OVER (
					PARTITION BY start_station_id,
					start_day_of_week,
					member_casual
					) total_rides
			FROM [ride_data] rd
			INNER JOIN [geography] g
				ON rd.start_station_id = g.station_id
			) t1
		) t2
	) t3
WHERE rides_sum_rank BETWEEN 1
		AND 20;