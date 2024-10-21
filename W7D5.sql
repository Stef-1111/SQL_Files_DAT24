-- 7 

SELECT g.name 
FROM track t
LEFT JOIN genre g on t.GenreId = g.GenreId
Group by g.name
HAVING count(DISTINCT t.trackid) = (SELECT max(num_track)
	FROM (SELECT 
				G.name as genre_name, count(DISTINCT t.trackid) as num_track
                FROM 
					track t 
				left join 
					genre g on t.genreid = g.genreid 
				group by g.name) a );
                
		
-- 8 rivedi 