    /*question 13  */
   
SELECT ac.airline_name,
       monday_flights.cnt  AS monday_flights,
       sunday_flights .cnt AS sunday_flights
FROM   airline_codes ac,
       (SELECT fr.airline_code,
               Count(fr) AS cnt
        FROM   flight_reports fr
        WHERE  fr.weekday_id = 1
               AND fr.is_cancelled = 0
        GROUP  BY fr.airline_code) AS monday_flights,
       (SELECT fr.airline_code,
               Count(fr) AS cnt
        FROM   flight_reports fr
        WHERE  fr.weekday_id = 7
               AND fr.is_cancelled = 0
        GROUP  BY fr.airline_code) AS sunday_flights
WHERE  monday_flights .airline_code = ac.airline_code
       AND sunday_flights .airline_code = ac.airline_code
ORDER  BY ac.airline_name  
   