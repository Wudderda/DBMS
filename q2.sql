		/* q2*/
SELECT ac,
       Count(fr) AS cancel_count
FROM   flight_reports fr,
       airport_codes ac,
       cancellation_reasons cr
WHERE  origin_airport_code = ac.airport_code
       AND cr.reason_code = fr.cancellation_reason
       AND cr.reason_desc = 'Security'
GROUP  BY ac
ORDER  BY Count(fr) DESC,
          ac