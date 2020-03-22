	/* q4*/
select  
	ac.airline_name 
from 
	airline_codes ac  , 
	(select  distinct fr.airline_code 
	from flight_reports fr  
	where 
		fr.is_cancelled =0
		and (fr."year" = '2018' or fr."year" = '2019')
		and fr.dest_city_name = 'Boston, MA'
		and fr.is_cancelled =0
	    and exists(
	    	select * 
	    	from flight_reports fr2 
	    	where 
	    	fr2.is_cancelled =0
			and (fr2."year" = '2018' or fr2."year" = '2019')
			and fr.airline_code =fr2.airline_code 
			and fr2.dest_city_name ='New York, NY'
			and exists(
				select * 
		    	from flight_reports fr3 
		    	where 
		    	fr3.is_cancelled =0
				and (fr3."year" = '2018' or fr3."year" = '2019')
				and fr2.airline_code =fr3.airline_code 
				and fr3.dest_city_name ='Portland, ME'
				and exists (
					select *
					from flight_reports fr4 
					where 
			    	fr4.is_cancelled =0
					and (fr4."year" = '2018' or fr4."year" = '2019')
					and fr4.airline_code =fr3.airline_code 
					and fr4.dest_city_name ='Washington, DC'
					and exists (
						select *
						from flight_reports fr5
						where 
			    		fr5.is_cancelled =0
						and (fr5."year" = '2018' or fr5."year" = '2019')
						and fr5.airline_code =fr4.airline_code 
						and fr5.dest_city_name ='Philadelphia, PA'
					)
				)
			)
			)
	) as results 
where 
	results .airline_code =ac .airline_code 
	and results.airline_code  not in (
		select distinct fr.airline_code 
		from flight_reports fr , airline_codes ac
		where 
		fr.airline_code =ac.airline_code 
		and (fr."year" = '2016' or fr."year" = '2017')
		and fr.dest_city_name = 'Boston, MA'
		and fr.is_cancelled =0
	    and exists(
	    	select * 
	    	from flight_reports fr2 
	    	where 
	    	fr2.is_cancelled =0
			and (fr2."year" = '2016' or fr2."year" = '2017')
			and fr.airline_code =fr2.airline_code 
			and fr2.dest_city_name ='New York, NY'
			and exists(
				select * 
		    	from flight_reports fr3 
		    	where 
		    	fr3.is_cancelled =0
				and (fr3."year" = '2016' or fr3."year" = '2017')
				and fr2.airline_code =fr3.airline_code 
				and fr3.dest_city_name ='Portland, ME'
				and exists (
					select *
					from flight_reports fr4
					where 
			    	fr4.is_cancelled =0
					and (fr4."year" = '2016' or fr4."year" = '2017')
					and fr4.airline_code =fr3.airline_code 
					and fr4.dest_city_name ='Washington, DC'
					and exists (
						select *
						from flight_reports fr5 
						where 
			    		fr5.is_cancelled =0
						and (fr5."year" = '2016' or fr5."year" = '2017')
						and fr5.airline_code =fr4.airline_code 
						and fr5.dest_city_name ='Philadelphia, PA'
					)
				)
			)
		)
	)
		
		
		