
WITH bike AS (
    SELECT * FROM bike_share_yr_0
    UNION 
    SELECT * FROM bike_share_yr_1
)

SELECT 
    -- Divide the date into year and month
   CASE A.yr
        WHEN 0 THEN 2021
        WHEN 1 THEN 2022
    END AS ride_year,

    MONTH(CONVERT(date, A.dteday, 103)) AS ride_month,

    A.hr AS hour,

    -- Classify the hour into a time period
    CASE 
        WHEN A.hr BETWEEN 0 AND 5 THEN 'Night'
        WHEN A.hr BETWEEN 6 AND 11 THEN 'Morning'
        WHEN A.hr BETWEEN 12 AND 17 THEN 'Afternoon'
        WHEN A.hr BETWEEN 18 AND 23 THEN 'Evening'
        ELSE 'Unknown'
    END AS time_period,

    --  holiday
    CASE A.holiday
        WHEN 1 THEN 'Holiday'
        ELSE 'Non-Holiday'
    END AS holiday_status,

    -- day of the week 
    CASE A.weekday
        WHEN 0 THEN 'Sunday'
        WHEN 1 THEN 'Monday'
        WHEN 2 THEN 'Tuesday'
        WHEN 3 THEN 'Wednesday'
        WHEN 4 THEN 'Thursday'
        WHEN 5 THEN 'Friday'
        WHEN 6 THEN 'Saturday'
    END AS day_of_week,

    --  "Weekend" أو "Weekday"
    CASE A.weekday
        WHEN 0 THEN 'Weekend'
        WHEN 6 THEN 'Weekend'
        ELSE 'Weekday'
    END AS week_type,

    -- season
    CASE A.season
        WHEN 1 THEN 'Winter'
        WHEN 2 THEN 'Spring'
        WHEN 3 THEN 'Summer'
        WHEN 4 THEN 'Fall'
    END AS season,

    -- weather 
    CASE A.weathersit
        WHEN 1 THEN 'Clear'
        WHEN 2 THEN 'Cloudy'
        WHEN 3 THEN 'Rainy'
        WHEN 4 THEN 'Stormy'
    END AS weather,

   -- Edit column names
    A.temp AS temperature,
    A.atemp AS feels_like_temp,
    A.hum AS humidity,
    A.windspeed AS wind_speed,

    A.rider_type AS rider_category,
    A.riders AS rider_count,

    B.price AS ride_price,
    B.COGS AS ride_cost,

    -- revenue and profit
    (A.riders * B.price) AS revenue,
    (A.riders * B.price - A.riders * B.COGS) AS profit


	

	FROM 
    bike A
LEFT JOIN 
    cost_table B
ON 
    A.yr = B.yr