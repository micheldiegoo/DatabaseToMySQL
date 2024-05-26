CREATE OR REPLACE VIEW leevingl AS 
SELECT Property, Company, `Current Price`, `Type Room`, `Group Room`, `Vacancy Status`
FROM dataleevingl.database_leevingl21052024
WHERE Property <> 'Erin' and Landlord in ('BeLettings', 'Neil')
and `Vacancy Status` <> 'Blocked';


CREATE OR REPLACE VIEW count_vacancy_status as
SELECT Property, COUNT(`Vacancy Status`) as count_vacancy_status,
COUNT (`Group Room`) as count_beds
from dataleevingl.database_leevingl21052024
WHERE Property <> 'Erin' and Landlord in ('BeLettings', 'Neil')
and `Vacancy Status` <> 'Blocked'
group by Property;

CREATE OR REPLACE VIEW count_vacancy_status as
SELECT Property, count(vacancy_status) as count_vacancy_status, count(distinct group_room) as count_group_room
FROM dataleevingl.database_leevingl21052024
WHERE Property <> 'Erin' and Landlord in ('BeLettings', 'Neil')
and vacancy_status <> 'Blocked'
group by Property;


-- UPDATING
ALTER TABLE dataleevingl.database_leevingl21052024
RENAME column `Current Price` TO current_price;

update dataleevingl.database_leevingl21052024
set group_room = 'Room 1.3'
WHERE vacancy_ID = 'AR42B13';

select * from dataleevingl.database_leevingl21052024;


SELECT Property, group_room
from dataleevingl.database_leevingl21052024
WHERE group_room not in ('Restaurant', 'School') and group_room is not null;


USE database_leevingl21052024;

SELECT 
    Property, 
    group_room,
    SUBSTRING_INDEX(group_room, '.', 1) AS new_group_room,
    CONCAT(Property, ' ', SUBSTRING_INDEX(group_room, '.', 1)) AS concatenated_column
FROM 
    dataleevingl.database_leevingl21052024
WHERE 
    group_room NOT IN ('Restaurant', 'School') 
    AND group_room IS NOT NULL;
    
    
    SELECT 
    Property,
    COUNT(DISTINCT concatenated_column) AS distinct_count
    
FROM (
    SELECT 
        Property, 
        CONCAT(Property, ' ', SUBSTRING_INDEX(group_room, '.', 1)) AS concatenated_column
    FROM 
        dataleevingl.database_leevingl21052024
    WHERE 
        group_room NOT IN ('Restaurant', 'School') 
        AND group_room IS NOT NULL AND
        Property <> 'Erin' and Landlord in ('BeLettings', 'Neil')
		and vacancy_status <> 'Blocked'
) AS subquery
GROUP BY 
    Property;



