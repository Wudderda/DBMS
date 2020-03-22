/*question 9 */
SELECT DISTINCT fr.plane_tail_number,
                Avg(fr.flight_distance / fr.flight_time) AS avg_speed
FROM   flight_reports fr
WHERE  NOT EXISTS(SELECT *
                  FROM   flight_reports fr2
                  WHERE  fr2.plane_tail_number = fr.plane_tail_number
                         AND fr2."month" = 1
                         AND fr2."year" = 2016
                         AND fr2.weekday_id != 6
                         AND fr2.weekday_id != 7)
       AND fr."month" = 1
       AND fr."year" = 2016
       AND ( fr.weekday_id = 6
              OR fr.weekday_id = 7 )
       AND fr.is_cancelled = 0
GROUP  BY fr.plane_tail_number
ORDER  BY avg_speed DESC  