			/*question 6 */
		
SELECT week_table.week_day,
       week_table .avg_delay
FROM   (SELECT Min(avg_delay) AS min_one
        FROM   (SELECT week_day,
                       Avg(fr.departure_delay + fr.arrival_delay) AS avg_delay
                FROM   flight_reports fr,
                       weekdays week_day
                WHERE  fr.origin_city_name = 'Boston, MA'
                       AND fr.dest_city_name = 'San Francisco, CA'
                       AND fr.weekday_id = week_day.weekday_id
                GROUP  BY week_day) AS averages) AS min_time,
       (SELECT week_day,
               Avg(fr.departure_delay + fr.arrival_delay) AS avg_delay
        FROM   flight_reports fr,
               weekdays week_day
        WHERE  fr.origin_city_name = 'Boston, MA'
               AND fr.dest_city_name = 'San Francisco, CA'
               AND fr.weekday_id = week_day.weekday_id
        GROUP  BY week_day) AS week_table
WHERE  week_table.avg_delay = min_time.min_one  