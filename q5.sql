		
		/*question 5 */
	
SELECT ( Concat(fr."day", '/', fr."month", '/', fr."year") ),
       fr.plane_tail_number,
       fr.arrival_time,
       fr2.departure_time,
       fr.origin_city_name,
       fr.dest_city_name,
       fr2.dest_city_name,
       ( fr.flight_time + fr.taxi_out_time
         + fr2.taxi_in_time + fr2.flight_time )     AS total_time,
       ( fr.flight_distance + fr2.flight_distance ) AS total_distance
FROM   flight_reports fr,
       flight_reports fr2
WHERE  fr.is_cancelled = 0
       AND fr2.is_cancelled = 0
       AND fr.arrival_time < fr2.departure_time
       AND fr."day" = fr2."day"
       AND fr."month" = fr2."month"
       AND fr."year" = fr2."year"
       AND fr.origin_city_name = 'Seattle, WA'
       AND fr.plane_tail_number = fr2.plane_tail_number
       AND fr.dest_airport_code = fr2.origin_airport_code
       AND fr2.dest_city_name = 'Boston, MA'
ORDER  BY total_time,
          total_distance,
          fr.plane_tail_number,
          fr.dest_city_name  