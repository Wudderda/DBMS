/*question 11  */
 

  
SELECT ac2.airline_name,
       total_count."year",
       total_count.cnt     AS total_num_flights,
       cancelled_count.cnt AS cancelled_flights
FROM   airline_codes ac2,
       (SELECT Count(fr) AS cnt,
               fr."year",
               fr.airline_code
        FROM   flight_reports fr
        WHERE  fr.is_cancelled = 1
        GROUP  BY fr."year",
                  fr.airline_code) AS cancelled_count,
       (SELECT Count(fr) AS cnt,
               fr."year",
               fr.airline_code
        FROM   flight_reports fr
        GROUP  BY fr."year",
                  fr.airline_code) AS total_count
WHERE  cancelled_count."year" = total_count."year"
       AND total_count.airline_code = ac2.airline_code
       AND total_count.airline_code = cancelled_count .airline_code
       AND ac2 IN (SELECT ac
                   FROM   airline_codes ac,
                          (SELECT fr.airline_code,
                                  Count(fr) AS cnt
                           FROM   flight_reports fr
                           WHERE  fr."year" = 2016
                           GROUP  BY fr.airline_code,
                                     fr."day") AS popular_2016,
                          (SELECT fr.airline_code,
                                  Count(fr) AS cnt
                           FROM   flight_reports fr
                           WHERE  fr."year" = 2017
                           GROUP  BY fr.airline_code,
                                     fr."day") AS popular_2017,
                          (SELECT fr.airline_code,
                                  Count(fr) AS cnt
                           FROM   flight_reports fr
                           WHERE  fr."year" = 2018
                           GROUP  BY fr.airline_code,
                                     fr."day") AS popular_2018,
                          (SELECT fr.airline_code,
                                  Count(fr) AS cnt
                           FROM   flight_reports fr
                           WHERE  fr."year" = 2019
                           GROUP  BY fr.airline_code,
                                     fr."day") AS popular_2019
                   WHERE  popular_2019.airline_code = ac.airline_code
                          AND popular_2017.airline_code =
                              popular_2019.airline_code
                          AND popular_2016.airline_code =
                              popular_2019.airline_code
                          AND popular_2018.airline_code =
                              popular_2019.airline_code
                   GROUP  BY ac.airline_code
                   HAVING Avg(popular_2019.cnt) > 2000
                          AND Avg(popular_2018.cnt) > 2000
                          AND Avg(popular_2017.cnt) > 2000
                          AND Avg(popular_2016.cnt) > 2000)
ORDER  BY ac2.airline_name  
  