	/*question 7 */

SELECT DISTINCT ac.airline_name,
                ( ( cancelled_count .quantity * 100 ) / all_count.quantity )AS
                percentage
FROM   airline_codes ac,
       (SELECT Count(*)        AS quantity,
               fr.airline_code AS code
        FROM   flight_reports fr
        WHERE  fr.origin_city_name = 'Boston, MA'
               AND fr.is_cancelled = 1
        GROUP  BY fr.airline_code) AS cancelled_count,
       (SELECT Count(*)        AS quantity,
               fr.airline_code AS code
        FROM   flight_reports fr
        WHERE  fr.origin_city_name = 'Boston, MA'
        GROUP  BY fr.airline_code) AS all_count
WHERE  all_count.code = ac.airline_code
       AND cancelled_count.code = ac.airline_code
       AND ( ( cancelled_count .quantity * 100 ) / all_count.quantity ) > 10
ORDER  BY percentage DESC  