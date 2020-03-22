  /*question 12  */
  
SELECT boston_flights ."year",
       ac.airline_code,
       boston_flights. cnt
       AS boston_flight_count,
       Cast(boston_flights. cnt * 100 AS FLOAT) / Cast(all_flights.cnt AS FLOAT)
       AS
       boston_flight_percentage
FROM   airline_codes ac,
       (SELECT fr2.airline_code,
               Count(fr2) AS cnt,
               fr2."year"
        FROM   flight_reports fr2
        WHERE  fr2.dest_city_name = 'Boston, MA'
               AND fr2.is_cancelled = 0
        GROUP  BY fr2.airline_code,
                  fr2."year") AS boston_flights,
       (SELECT fr3.airline_code,
               Count(fr3) AS cnt,
               fr3."year"
        FROM   flight_reports fr3
        WHERE  fr3.is_cancelled = 0
        GROUP  BY fr3.airline_code,
                  fr3."year") AS all_flights
WHERE  ac.airline_code = all_flights .airline_code
       AND ac.airline_code = boston_flights .airline_code
       AND all_flights."year" = boston_flights ."year"
GROUP  BY ac.airline_code,
          boston_flights. cnt,
          all_flights.cnt,
          boston_flights ."year"
HAVING Cast(boston_flights. cnt * 100 AS FLOAT) / Cast(all_flights.cnt AS FLOAT)
       > 1
ORDER  BY boston_flights ."year",
          ac.airline_code  