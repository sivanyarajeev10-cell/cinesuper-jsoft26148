-- SCRIPT 4: VIEW FOR AVERAGE RATINGS

create view movie_ratings
with (security_invoker = on) as
select
  m.id,
  m.title,
  round(avg(r.rating), 1) as avg_rating,
  count(r.id)             as review_count
from movies m
left join reviews r on r.movie_id = m.id
group by m.id, m.title;

grant select on movie_ratings to anon, authenticated;

-- test it
select * from movie_ratings order by avg_rating desc nulls last;