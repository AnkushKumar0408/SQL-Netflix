DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
	show_id	VARCHAR(5),
	type    VARCHAR(10),
	title	VARCHAR(250),
	director VARCHAR(550),
	casts	VARCHAR(1050),
	country	VARCHAR(550),
	date_added	VARCHAR(55),
	release_year	INT,
	rating	VARCHAR(15),
	duration	VARCHAR(15),
	listed_in	VARCHAR(250),
	description VARCHAR(550)
);

select * from netflix;

select count(*) as total_content 
from netflix;



-- 10 Business Problems & Solutions

-- 1. Count the number of Movies vs TV Shows

select type, count(*) as total_content
from netflix
group by type;


-- 2. Find the most common rating for movies and TV shows

select type,rating,count(rating) as rating_Count
from netflix
group by type,rating
order by 1,3 desc;

select type,rating
from
(
select type,rating,count(*),
rank() over(partition by type order by count(*) desc) as ranking
from netflix
group by type,rating
) as t1
where ranking = 1


-- 3. List all movies released in a specific year (e.g., 2020)


select * from netflix 
where release_year = 2020 and type = 'Movie'


-- 4. Find the top 5 countries with the most content on Netflix

select * from netflix

select country,count(show_id) as count
from netflix
group by country
order by count desc
limit 5


SELECT 
UNNEST(STRING_TO_ARRAY(country,',')) as new_country,
count(show_id) as total_content
from netflix
group by 1
order by 2 desc
limit 5


-- 5. Identify the longest movie


select * from netflix
where type = 'Movie'
and 
duration = (select max(duration) from netflix)
limit 1

-- 6. Find content added in the last 5 years

select * from netflix
where 
to_date(date_added,'Month DD YYYY') >= current_date - interval '5 years'

-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

select count(*),
unnest (string_to_array(director,',')) as new_director
from netflix
where director = 'Rajiv Chilaka'
group by 2



select * from netflix
where director ilike '%Rajiv Chilaka%'





-- 8. List all TV shows with more than 5 seasons

select *
from netflix
where type = 'TV Show'
and 
left(duration,1) :: numeric > 5


select *
from netflix
where type = 'TV Show'
and 
split_part(duration,' ',1) :: numeric > 5



-- 9. Count the number of content items in each genre


select count(*),
unnest (string_to_array(listed_in,',')) as genre
from netflix
group by 2
order by 1 desc



-- 10.Find each year and the average numbers of content release in India on netflix.

select * from netflix


select count(*), release_year,
unnest (string_to_array(country,',')) as new_Country
from netflix
where country = 'India'
group by 2,3
order by 2
