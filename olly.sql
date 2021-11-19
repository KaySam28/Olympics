

---Overview of the data
SELECT *
FROM [dbo].[athletes_event_results]

SELECT SUM(AGE)
FROM [dbo].[athletes_event_results]

SELECT *
FROM [dbo].[team_info]

--How many teams are there?

SELECT COUNT(DISTINCT noc) as TeamsAvailable
FROM [dbo].[athletes_event_results]


--How many events are there

SELECT COUNT(DISTINCT event) as TotalEvents
FROM [dbo].[athletes_event_results]

--How many sports are there?

SELECT COUNT(DISTINCT sport) as TotalSports
FROM [dbo].[athletes_event_results]


--Total number of participants for each summer games since it began
select count( name) as Num,games
from [dbo].[athletes_event_results]
where games like '%summer%'
group by games 
order by games





--Sports participated most by femlaes

select 
		distinct sport,
		count(sex) as FemaleParticipants
from [dbo].[athletes_event_results]
where sex = 'f'
group by sport
order by count(sex) desc


--Sports participated most by Males
select 
		distinct sport,
		count(sex) as maleParticipants
from [dbo].[athletes_event_results]
where sex = 'm'
group by sport
order by count(sex) desc


--Analyze and visualize the % of athletes who were female over time.

		--Finding the number of females at each Olympic Game
select count( name) as Females,Games
from [dbo].[athletes_event_results]
where games like '%summer%' and sex = 'f'
group by games 
order by games


		--Finding the number of Males at each olympic game
select count( name) as Males,Games
from [dbo].[athletes_event_results]
where games like '%summer%' and sex = 'm'
group by games 
order by games


--Compare and contrast the summer and the winter games...

--How many athletes compete?
	--Participants in the summer games
select count(distinct name) As participants
from [dbo].[athletes_event_results]
where games like '%summer%'


		--Participants in the winter games
select count(distinct name) As participants
from [dbo].[athletes_event_results]
where games like '%winter%'


	--The total number of Countries to have participated in the summer games
select count(distinct NOC)
from [dbo].[athletes_event_results]
where games like '%summer%'


		--The total number of countries to have participated in the Winter games
select count(distinct NOC)
from [dbo].[athletes_event_results]
where games like '%WINTER%'


		--The number of events available at Summer games
select count(distinct event) as GamesAtSummerGames
from [dbo].[athletes_event_results]
where games like '%summer%'

select count(distinct event) GamesAtWinterGames
from [dbo].[athletes_event_results]
where games like '%winter%'


--Which countries send the most athletes to the olympics?
select t.team,a.noc, count(t.noc) Num
from [dbo].[athletes_event_results] a
join [dbo].[team_info] t
on a.noc=t.noc
group by t.team,a.noc
order by Num desc


select noc,count(noc)
from [dbo].[athletes_event_results]
group by noc
order by count(noc) desc

--Which countries lead the medal count? Are those country with the highest representatives the same leading the highest count?
select noc,count(medal),medal
from [dbo].[athletes_event_results]
where medal <> 'na'
group by noc,medal
order by count(medal) desc



--Sporting event with the heaviest participants averagely
select  
		Top 5
		sport,
		round(avg(weight),2) as AverageWeight
from[dbo].[athletes_event_results]
--where medal <> 'NA' 
GROUP by sport
order by 2 desc


--Height of medalist varied by sport
select  
		Top 5
		sport,
		round(avg(height),2)as AverageHeight
from[dbo].[athletes_event_results]
where medal <> 'NA' 
GROUP by sport
order by 2 desc


--Average age of medalist in each sport
select round(avg(age),2) as AverageAge,sport
from [dbo].[athletes_event_results]
where medal<>'NA'
group by sport
order by averageage desc



--Top 5 oldest people to participate in the copetition

select 
		Top 5
		Age,
		Name,
		Sport,
		Games
from [dbo].[athletes_event_results]
order by age desc



--Persons with the most Gold medals at the Olympics

SELECT Top 10
			name,
			sex,
			A.NOC,
			SPORT,
			SUM(CASE medal
						  WHEN 'Gold' THEN 1
						  WHEN 'Silver' THEN 1
						  WHEN 'Bronze' THEN 1
							ELSE 0
						  END) As MedalCount,

			 Team
FROM  [dbo].[athletes_event_results] a
join [dbo].[team_info] t
on t.noc=a.noc
GROUP BY
name, sex, a.
noc, sport,team
ORDER BY MedalCount desc


--The last 6 women football Olympic final list


SELECT 
	Top 6
	Silver,
	Gold,
	babe.games
from 
		(select games, noc as Gold
			from [dbo].[athletes_event_results]
			where sport='Football' and sex ='f' and medal ='gold'
			group by games,noc) Babe,
(
			select games,noc as Silver 
			from [dbo].[athletes_event_results]
			where sport = 'football' and sex ='f' and medal = 'silver'
			group by games ,noc) Boo
where babe.games=boo.games
order by games desc




--The last 6 women football Olympic final list

SELECT 
	Top 6
	Silver,
	Gold,
	babe.games
from 
		(select games, noc as Gold
			from [dbo].[athletes_event_results]
			where sport='Football' and sex ='m' and medal ='gold'
			group by games,noc) Babe,
(
			select games,noc as Silver 
			from [dbo].[athletes_event_results]
			where sport = 'football' and sex ='m' and medal = 'silver'
			group by games ,noc) Boo
where babe.games=boo.games
order by games desc








--Create view Olly as 
--SELECT 
--ID,
--NAME AS 'Competitor Name',
--case when SEX ='M' then 'Male' ELSE 'Female' END AS SEX,
--AGE,
--CASE WHEN AGE < 18 THEN 'UNDER 18'
--	 WHEN AGE BETWEEN 18 AND 25 THEN '18-25'
--	 WHEN AGE BETWEEN 25 AND 30 THEN '25-30'
--	 WHEN AGE >30 THEN 'Over 30'
--	 END AS 'AGE GROUPING',
--HEIGHT,
--WEIGHT,
--NOC AS 'NATION CODE',
--CHARINDEX (' ', GAMES)-1 AS 'Example 1',
--CHARINDEX(' ',REVERSE(GAMES))-1 AS 'Example 2',
--LEFT(GAMES, CHARINDEX(' ',Games)-1) as 'Year',
--RIGHT(GAMES, CHARINDEX(' ',REVERSE(Games))-1) as 'Season',
--Sport,
--Event,
--CASE WHEN Medal ='NA'THEN 'Not Registered' ELSE Medal END AS Medal
--FROM [dbo].[athletes_event_results]
--WHERE RIGHT(GAMES, CHARINDEX(' ',REVERSE(Games))-1) = 'Summer'