USE imdb

-- To check the  total values stored in columns

select count(*) from genre;
select count(*) from director_mapping;
select count(*) from movie;
select count(*) from names;
select count(*) from ratings;
select count(*) from role_mapping;

-- TO check the null values in the columns

select count(*) from movie where title is null;
select count(*) from movie where country is Null;
select count(*) from movie where worlwide_gross_income is null;

-- to check the total number of movies in a year seperately we use group by

select year, count(id) as number_of_movies from movie group by year;

-- to check the total number of movies in a month seperately we use group by and to get in order use order by 
select month(date_published) as month_num , count(id) as number_of_movies from movies group by month(date_published) order by month_num;

-- how many movies were produced in the USA or India in the year 2019?
select count(*) from movie where year=2019 AND (Country="India" or Country="USA");

-- Find the unique list of the genres present in data set

select distinct genre from genre;

-- Which genre had highest number of movies
select genre, count(movie_id) as no_of_movies from genre group by genre order by no_of_movies desc limit 5;

-- how many movies belongs to one genre , we use CTE(Common Table Expression ) or we call it as bucket 
with summary AS
(
select movie_id , count(genre) as  no_of_genres from genre group by movie_id order by no_of_genres desc)

Select count(*) from Summary where no_of_genres=1;
-- to show the rank of genre
with summary AS (
select genre, count(movie_id) as no_of_movies ,RANK()over (order by count(movie_id) desc) as genre_rank
from genre group by genre)
select * from summary where genre="Comedy";

--
select max(avg_rating) as Max_Rating,min(avg_rating) as Min_Rating from ratings;

-- here we join two tables
select genre, avg(duration) as avg_duration 
from movie INNER JOIN genre ON genre.movie_id = movie.id group by genre order by avg_duration desc;

-- top movies based on avg rating

select title, avg_rating, DENSE_RANK()over (order by avg_rating desc) as movie_rank
from movie INNER JOIN ratings ON movie.id=ratings.movie_id ;
