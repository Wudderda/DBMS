   /*question 15 */
  
SELECT *
FROM  (SELECT ac.airport_desc
       FROM   airport_codes ac,
              (SELECT Count(fr)              AS cnt,
                      fr.origin_airport_code AS code
               FROM   flight_reports fr
               GROUP  BY fr.origin_airport_code) AS outgoing,
              (SELECT Count(fr)            AS cnt,
                      fr.dest_airport_code AS code
               FROM   flight_reports fr
               GROUP  BY fr.dest_airport_code) AS incoming
       WHERE  outgoing.code = ac.airport_code
              AND incoming.code = ac.airport_code
       ORDER  BY ( outgoing .cnt + incoming .cnt )DESC,
                 ac.airport_desc) AS t1
LIMIT  5  