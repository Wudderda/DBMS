   /*question 14 */
SELECT cr.reason_desc,
       compare_reasons."year",
       w.weekday_name,
       compare_reasons.cnt AS number_of_cancellations
FROM   cancellation_reasons cr,
       weekdays w,
       (SELECT Max(reasons .cnt) AS max_one,
               reasons ."year",
               reasons .weekday_id
        FROM   (SELECT fr."year",
                       fr.weekday_id,
                       fr.cancellation_reason,
                       Count(fr) AS cnt
                FROM   flight_reports fr
                WHERE  fr.is_cancelled = 1
                GROUP  BY fr."year",
                          fr.weekday_id,
                          fr.cancellation_reason) AS reasons
        GROUP  BY reasons ."year",
                  reasons .weekday_id) AS max_of_time,
       (SELECT fr."year",
               fr.weekday_id,
               fr.cancellation_reason,
               Count(fr) AS cnt
        FROM   flight_reports fr
        WHERE  fr.is_cancelled = 1
        GROUP  BY fr."year",
                  fr.weekday_id,
                  fr.cancellation_reason) AS compare_reasons
WHERE  compare_reasons."year" = max_of_time."year"
       AND compare_reasons.weekday_id = max_of_time.weekday_id
       AND compare_reasons.cnt = max_of_time.max_one
       AND max_of_time.weekday_id = w.weekday_id
       AND compare_reasons .cancellation_reason = cr.reason_code
ORDER  BY compare_reasons."year",
          w .weekday_id  