--  * Data Cleaning *
select * from athlete_events

--Start with Handeling Tiness Issues
--Split column 'Event' to Event Name & Event Type AND remove sentence 'Unknown Event'
ALTER TABLE athlete_events
ADD Event_Type VARCHAR(255), 
    Event_Name VARCHAR(255);

UPDATE athlete_events
SET 
    Event_Type = CASE 
                    WHEN CHARINDEX(',', event) > 0 THEN 
                        SUBSTRING(event, 1, CHARINDEX(',', event) - 1) 
                    ELSE 
                        event  -- or NULL, or any default value if no comma is found
                 END,
    Event_Name = CASE 
                    WHEN CHARINDEX(',', event) > 0 THEN 
                        SUBSTRING(event, CHARINDEX(',', event) + 2, LEN(event)) 
                    ELSE 
                        NULL  -- or any default value if no comma is found
                 END;


ALTER TABLE athlete_events
DROP COLUMN event;

UPDATE athlete_events
SET Event_Type = REPLACE(Event_Type,'Unknown Event','')
WHERE Event_Type LIKE '%Unknown Event%'

--column 'Team' should be changed to 'Team Country'
EXEC sp_rename 'athlete_events.[Team Country]', 'TEAM COUNTRY', 'COLUMN';


--Column 'Games' has no added information, as the year & season are exist in separeted columns , so delete Column 'Games'
ALTER TABLE athlete_events
DROP COLUMN Games;

----------------------------------------------------
--Check for NULLs
select * from athlete_events

SELECT DISTINCT Sex FROM athlete_events
SELECT DISTINCT Team FROM athlete_events
SELECT DISTINCT Season FROM athlete_events
SELECT DISTINCT Sport FROM athlete_events
SELECT DISTINCT Medal FROM athlete_events
SELECT DISTINCT Event_Name FROM athlete_events 
SELECT DISTINCT Year FROM athlete_events 


SELECT 
    Age, 
    COUNT(Age) 
FROM 
    athlete_events
GROUP BY 
    Age


SELECT  count(Height) AS HEIGHT_COUNT
FROM athlete_events 
where Height ='NA' 

SELECT count(Weight) AS WEIGHT_COUNT
FROM athlete_events 
where Weight='NA'

SELECT count(Medal) AS WEIGHT_COUNT
FROM athlete_events 
where Medal='NA'

--Almost all values in height & weight  & Event_Name & Age are NULLs , so drop them
ALTER TABLE athlete_events
DROP COLUMN Weight,Height,Event_Name,Age

alter table athlete_events
add  Medal  varchar(250)

update athlete_events
set Medal=case
			when ID < 7000 then 'Gold'
			when ID>7000 AND ID <14000 then 'silver'
			WHEN ID>14000 THEN 'bronze'
			END

--------------------------------------------------------------------------
--Check for duplicated records
SELECT Name,Event,Year,COUNT(*)
FROM athlete_events
GROUP BY Name,Event,Year
HAVING count(*)>1

--There are many dupicated records
--Delete all duplicated records

ALTER TABLE athlete_events ADD row_num INT IDENTITY(1,1);

DELETE FROM athlete_events
Where row_num not in(
					SELECT min(row_num)
					FROM athlete_events
					GROUP BY Name,Event,Year
					HAVING count(*)>1)

ALTER TABLE athlete_events DROP COLUMN row_num;

------------------------------------------------------------
--Convert M,F in Sex to Male,Female
ALTER TABLE athlete_events
ALTER COLUMN Sex VARCHAR(10)
UPDATE athlete_events
SET Sex=case
		 when Sex='M' then 'Male' else 'Female' 
		end;
      
-----------------------------------------

--Answer Qusettions
-- 1. How many olympics games have been held?
SELECT COUNT(DISTINCT Event_Type)
FROM athlete_events

-- 2. List down all Olympics games held so far.
SELECT DISTINCT Event_Type
FROM athlete_events

-- 3. Mention the total no of nations who participated in each olympics game?
SELECT COUNT(DISTINCT [[TEAM COUMNTRY]]])
FROM athlete_events

-- 4. Which year saw the highest and lowest no of countries participating in olympics?

SELECT Year,COUNT([[TEAM COUMNTRY]]]) AS COUNTRY_COUNT
FROM athlete_events
GROUP BY Year
HAVING COUNT([[TEAM COUMNTRY]]])=
								(SELECT MAX(COUNTRY_COUNT)
								 FROM(
									  SELECT COUNT([[TEAM COUMNTRY]]]) AS COUNTRY_COUNT
									  FROM athlete_events
									  GROUP BY Year)AS YEAR_COUNT);


SELECT Year,COUNT([[TEAM COUMNTRY]]]) AS COUNTRY_COUNT
FROM athlete_events
GROUP BY Year
HAVING COUNT([[TEAM COUMNTRY]]])=(
								  SELECT MIN(COUNTRY_COUNT)
								  FROM (SELECT COUNT([[TEAM COUMNTRY]]]) AS COUNTRY_COUNT
										 FROM athlete_events
										 GROUP BY Year) AS YEAR_COUNTRY);



-- 5. Which nation has participated in all of the olympic games?
SELECT [[TEAM COUMNTRY]]],COUNT(DISTINCT Event_Type)
FROM athlete_events
GROUP BY [[TEAM COUMNTRY]]]
HAVING COUNT(DISTINCT Event_Type)=(
									SELECT MAX(COUNT_)
									FROM (SELECT COUNT(DISTINCT Event_Type) AS COUNT_
									      FROM athlete_events
										  ) AS COUNT__)

-- 6. Identify the sport which was played in all summer olympics.
SELECT SPORT,count(distinct year) as summer_olympics
from athlete_events
WHERE SEASON ='Summer'
GROUP BY SPORT
Having count(distinct year) = (select count(distinct year) from athlete_events)

-- 7. Which Sports were just played only once in the olympics?
SELECT SPORT,count( year) as summer_olympics
from athlete_events
GROUP BY SPORT
Having count( year) = 1

-- 8. Fetch the total no of sports played in each olympic games.
SELECT YEAR as 'olympic games',COUNT(DISTINCT SPORT) AS 'number of sports'
FROM athlete_events
GROUP BY YEAR

-- 9. Fetch details of the oldest athletes to win a gold medal.
SELECT *
FROM athlete_events
WHERE YEAR=(SELECT MIN(YEAR) FROM athlete_events) AND MEDAL='Gold'

-- 10. Find the Ratio of male and female athletes participated in all olympic games.
select 
	(COUNT(CASE WHEN Sex='Female' THEN 1 END))*1.0 / (COUNT(*))*100 AS 'Female Ratio' 
	FROM athlete_events

SELECT 
	  (COUNT(CASE WHEN SEX='Male' THEN 1 END)*1.0)/COUNT(*)*100 AS 'Male Ratio' 
	  FROM athlete_events

-- 11. Fetch the top 3 athletes who have won the most gold medals.

select top 3 Name,count(Medal) as gold_count
from athlete_events
where Medal='Gold'
group by Name
order by gold_count DESC

   --METHOD 2
select TOP 3 NAME,
    DENSE_RANK() OVER( ORDER BY COUNT(MEDAL)) AS RANKK
from athlete_events
where Medal='Gold'
GROUP BY NAME
ORDER BY RANKK DESC

-- 12. Fetch the top 5 athletes who have won the most medals (gold/silver/bronze).
select TOP 5 NAME,
    DENSE_RANK() OVER( ORDER BY COUNT(MEDAL)) AS RANKK
from athlete_events
GROUP BY NAME
ORDER BY RANKK DESC

-- 13. Fetch the top 5 most successful countries in olympics. Success is defined by no of medals won.
select TOP 5 [[TEAM COUMNTRY]]],
    DENSE_RANK() OVER( ORDER BY COUNT(MEDAL)) AS RANKK
from athlete_events
GROUP BY [[TEAM COUMNTRY]]]
ORDER BY RANKK DESC

