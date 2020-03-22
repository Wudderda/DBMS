/*question 8 */

SELECT DISTINCT tb2.plane_tail_number,
                tb2.airline_code AS first_owner,
                fr2.airline_code AS second_owner
FROM   flight_reports fr2,
       (SELECT tb1.plane_tail_number,
               Min(tb1.dte) AS dte
        FROM   (SELECT fr.plane_tail_number,
                       fr.airline_code,
                       Min(fr."year" * 372 + fr."month" * 31 + fr."day") AS dte
                FROM   flight_reports fr
                GROUP  BY fr.plane_tail_number,
                          fr.airline_code) AS tb1
        GROUP  BY tb1.plane_tail_number
        HAVING Count(tb1.plane_tail_number) > 1) AS duplicated_ones,
       (SELECT fr.plane_tail_number,
               fr.airline_code,
               Min(fr."year" * 372 + fr."month" * 31 + fr."day") AS dte
        FROM   flight_reports fr
        GROUP  BY fr.plane_tail_number,
                  fr.airline_code) AS tb2
WHERE  fr2.plane_tail_number = duplicated_ones.plane_tail_number
       AND tb2.plane_tail_number = duplicated_ones.plane_tail_number
       AND tb2.airline_code != fr2.airline_code
       AND tb2.dte < ( fr2."year" * 372 + fr2."month" * 31 + fr2."day" )
ORDER  BY tb2.plane_tail_number,
          first_owner,
          second_owner  
