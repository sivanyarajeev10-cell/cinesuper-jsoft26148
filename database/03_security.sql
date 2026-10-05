-- SCRIPT 3: SECURITY (RLS + GRANTS)

alter table genres  enable row level security;
alter table movies  enable row level security;
alter table reviews enable row level security;

create policy "Public can read genres"
  on genres for select to anon, authenticated using (true);

create policy "Public can read movies"
  on movies for select to anon, authenticated using (true);

create policy "Public can read reviews"
  on reviews for select to anon, authenticated using (true);

create policy "Public can add reviews"
  on reviews for insert to anon, authenticated
  with check (
    rating between 1 and 5
    and length(trim(reviewer_name)) between 1 and 50
    and length(coalesce(comment, '')) <= 500
  );

grant usage  on schema public to anon, authenticated;
grant select on genres, movies, reviews to anon, authenticated;
grant insert on reviews to anon, authenticated;