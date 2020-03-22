/*question 10 */

SELECT DISTINCT ac.airline_name,
                Count(fr)
FROM   airline_codes ac,
       world_area_codes wac,
       flight_reports fr
WHERE  NOT EXISTS (SELECT *
                   FROM   flight_reports fr2
                   WHERE  fr2.plane_tail_number = fr.plane_tail_number
                          AND fr2.dest_wac_id != wac.wac_id
                          AND fr2.is_cancelled = 0)
       AND fr.is_cancelled = 0
       AND fr.dest_wac_id = wac.wac_id
       AND fr.airline_code = ac.airline_code
       AND wac.wac_name = 'Texas'
GROUP  BY ac.airline_name
ORDER  BY ac.airline_name  