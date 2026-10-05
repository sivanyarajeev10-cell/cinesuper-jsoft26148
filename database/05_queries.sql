-- SCRIPT 5: PRACTICE QUERIES

-- Q1. Movies with genre name (INNER JOIN)
select m.title, m.release_year, g.name as genre
from movies m join genres g on g.id = m.genre_id;

-- Q2. Movies per genre (GROUP BY)
select g.name, count(m.id) as total_movies
from genres g left join movies m on m.genre_id = g.id
group by g.name order by total_movies desc;

-- Q3. Movies longer than 150 minutes
select title, duration_min
from movies
where duration_min > 150;

-- Q4. Malayalam movies after 2015
select title, release_year
from movies
where language = 'Malayalam' and release_year > 2015;

-- Q5. Average rating at least 4.5 (HAVING)
select m.title, round(avg(r.rating),1) as avg_rating
from movies m join reviews r on r.movie_id = m.id
group by m.title having avg(r.rating) >= 4.5;

-- Q6. Movies with no reviews (subquery)
select title
from movies
where id not in (select movie_id from reviews);

-- Q7. Longest movie
select title, duration_min
from movies
where duration_min = (select max(duration_min) from movies);

-- Q8. Update a description
update movies
set description = 'An epic sci-fi journey through space and time.'
where title = 'Interstellar';

-- PART B.1. All reviews with movie title

select
  r.reviewer_name,
  r.rating,
  r.comment,
  m.title
from reviews r
join movies m on m.id = r.movie_id;


-- PART B.2. Number of movies per language

select language, count(*) as total_movies
from movies
group by language
order by total_movies desc;


-- PART B.3. Newest movie in database

select title, release_year
from movies
order by release_year desc
limit 1;


-- PART B.4. Titles starting with M

select title, release_year
from movies
where title like 'M%';


-- PART B.5. Delete one review

delete from reviews
where id = (
  select min(id) from reviews
);