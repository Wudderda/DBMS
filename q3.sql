	/* q3*/
SELECT X.plane_tail_number,
       "year",
       Avg(X.total) AS daily_avg
FROM   (SELECT fr.plane_tail_number,
               "year",
               Count(*) AS total
        FROM   flight_reports fr
        WHERE  is_cancelled = 0
        GROUP  BY "day",
                  fr.plane_tail_number,
                  "year") AS X
GROUP  BY X."year",
          X.plane_tail_number
HAVING Avg(X.total) > 5
ORDER  BY X.plane_tail_number,
          X."year"  
