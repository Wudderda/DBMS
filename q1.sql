	/* q1*/
SELECT ac.airline_name,
       ac.airline_code,
       Avg(departure_delay)
FROM   airline_codes ac,
       flight_reports fr
WHERE  fr."year" = '2018'
       AND ac.airline_code = fr.airline_code
       AND fr.is_cancelled = 0
GROUP  BY ac.airline_code,
          ac.airline_name
ORDER  BY Avg(departure_delay),
          ac.airline_name  