-- SCRIPT 2: SAMPLE DATA (Malayalam, Tamil and Christopher Nolan movies)

insert into genres (name) values
  ('Action'), ('Drama'), ('Comedy'), ('Sci-Fi'), ('Thriller'), ('Biography');

insert into movies (title, release_year, language, duration_min, description, poster_url, genre_id) values
  -- Malayalam
  ('Drishyam', 2013, 'Malayalam', 160,
   'A cable operator goes to any length to protect his family after an accidental crime.',
   'https://placehold.co/300x450/7f1d1d/ffffff?text=Drishyam',
   (select id from genres where name = 'Thriller')),
  ('Premam', 2015, 'Malayalam', 156,
   'George falls in love three times, from school days to adulthood.',
   'https://placehold.co/300x450/831843/ffffff?text=Premam',
   (select id from genres where name = 'Drama')),
  ('Bangalore Days', 2014, 'Malayalam', 171,
   'Three cousins from Kerala chase their dreams in Bangalore.',
   'https://placehold.co/300x450/065f46/ffffff?text=Bangalore+Days',
   (select id from genres where name = 'Comedy')),
  ('Minnal Murali', 2021, 'Malayalam', 158,
   'A village tailor gets superpowers after being struck by lightning.',
   'https://placehold.co/300x450/1e3a8a/ffffff?text=Minnal+Murali',
   (select id from genres where name = 'Action')),
  ('Manjummel Boys', 2024, 'Malayalam', 135,
   'Friends from Kochi race to rescue one of them trapped in the Guna Caves.',
   'https://placehold.co/300x450/422006/ffffff?text=Manjummel+Boys',
   (select id from genres where name = 'Thriller')),
  -- Tamil
  ('Vikram', 2022, 'Tamil', 174,
   'A special agent investigates masked murders linked to a drug cartel.',
   'https://placehold.co/300x450/111827/ffffff?text=Vikram',
   (select id from genres where name = 'Action')),
  ('96', 2018, 'Tamil', 158,
   'Two school sweethearts meet again at a reunion, twenty-two years later.',
   'https://placehold.co/300x450/9d174d/ffffff?text=96',
   (select id from genres where name = 'Drama')),
  ('Jai Bhim', 2021, 'Tamil', 164,
   'A lawyer fights for justice for a tribal woman whose husband goes missing in custody.',
   'https://placehold.co/300x450/1e40af/ffffff?text=Jai+Bhim',
   (select id from genres where name = 'Drama')),
  -- Christopher Nolan
  ('Memento', 2000, 'English', 113,
   'A man with short-term memory loss hunts his wife''s killer using notes and tattoos.',
   'https://placehold.co/300x450/374151/ffffff?text=Memento',
   (select id from genres where name = 'Thriller')),
  ('The Dark Knight', 2008, 'English', 152,
   'Batman faces the Joker, a criminal who wants to plunge Gotham into chaos.',
   'https://placehold.co/300x450/0f172a/ffffff?text=The+Dark+Knight',
   (select id from genres where name = 'Action')),
  ('Inception', 2010, 'English', 148,
   'A thief who steals secrets through dreams is asked to plant an idea instead.',
   'https://placehold.co/300x450/334155/ffffff?text=Inception',
   (select id from genres where name = 'Sci-Fi')),
  ('Interstellar', 2014, 'English', 169,
   'Astronauts travel through a wormhole to find a new home for humanity.',
   'https://placehold.co/300x450/0c4a6e/ffffff?text=Interstellar',
   (select id from genres where name = 'Sci-Fi')),
  ('Oppenheimer', 2023, 'English', 180,
   'The story of J. Robert Oppenheimer and the creation of the atomic bomb.',
   'https://placehold.co/300x450/7c2d12/ffffff?text=Oppenheimer',
   (select id from genres where name = 'Biography'));

insert into reviews (movie_id, reviewer_name, rating, comment) values
  ((select id from movies where title = 'Drishyam'),        'Anjali',  5, 'Georgekutty is a genius!'),
  ((select id from movies where title = 'Drishyam'),        'Arjun',   5, 'Best thriller ever.'),
  ((select id from movies where title = 'Premam'),          'Sreya',   4, 'Malar teacher steals the show.'),
  ((select id from movies where title = 'Manjummel Boys'),  'Akhil',   5, 'Gripping survival story.'),
  ((select id from movies where title = 'Vikram'),          'Fathima', 4, 'Mass climax!'),
  ((select id from movies where title = 'Interstellar'),    'Nikhil',  5, 'Mind-blowing science.'),
  ((select id from movies where title = 'Inception'),       'Arjun',   4, 'Need to watch it twice.'),
  ((select id from movies where title = 'The Dark Knight'), 'Akhil',   5, 'The Joker is legendary.');
  