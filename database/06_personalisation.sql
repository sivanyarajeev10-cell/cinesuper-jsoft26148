-- Phase 12: Personalisation

-- 12.1 Add a new genre
insert into genres (name)
values ('Romance');

-- 12.1 Add 5 new movies
insert into movies
(title, release_year, language, duration_min, description, poster_url, genre_id)
values
(
  'Premalu',
  2024,
  'Malayalam',
  156,
  'A fun romantic comedy about two young people who meet in Hyderabad.',
  'https://placehold.co/300x450?text=Premalu',
  (select id from genres where name = 'Romance')
),
(
  'Hridayam',
  2022,
  'Malayalam',
  172,
  'A coming-of-age romantic drama following a young man through different stages of life.',
  'https://placehold.co/300x450?text=Hridayam',
  (select id from genres where name = 'Romance')
),
(
  'Kumbalangi Nights',
  2019,
  'Malayalam',
  135,
  'A family drama about four brothers living together in Kumbalangi.',
  'https://placehold.co/300x450?text=Kumbalangi+Nights',
  (select id from genres where name = 'Drama')
),
(
  'Aavesham',
  2024,
  'Malayalam',
  158,
  'Three college students become involved with a local gangster in Bengaluru.',
  'https://placehold.co/300x450?text=Aavesham',
  (select id from genres where name = 'Action')
),
(
  'Super Sharanya',
  2022,
  'Malayalam',
  128,
  'A comedy about a young woman navigating college life and relationships.',
  'https://placehold.co/300x450?text=Super+Sharanya',
  (select id from genres where name = 'Comedy')
);

-- 12.2 Add director information
alter table movies
add column director text;

update movies set director = 'Jeethu Joseph' where title = 'Drishyam';
update movies set director = 'Alphonse Puthren' where title = 'Premam';
update movies set director = 'Anjali Menon' where title = 'Bangalore Days';
update movies set director = 'Basil Joseph' where title = 'Minnal Murali';
update movies set director = 'Chidambaram' where title = 'Manjummel Boys';
update movies set director = 'Lokesh Kanagaraj' where title = 'Vikram';
update movies set director = 'C. Prem Kumar' where title = '96';
update movies set director = 'T. J. Gnanavel' where title = 'Jai Bhim';

update movies
set director = 'Christopher Nolan'
where title in (
  'Memento',
  'The Dark Knight',
  'Inception',
  'Interstellar',
  'Oppenheimer'
);

update movies set director = 'Girish A. D.' where title = 'Premalu';
update movies set director = 'Vineeth Sreenivasan' where title = 'Hridayam';
update movies set director = 'Madhu C. Narayanan' where title = 'Kumbalangi Nights';
update movies set director = 'Jithu Madhavan' where title = 'Aavesham';
update movies set director = 'Girish A. D.' where title = 'Super Sharanya';