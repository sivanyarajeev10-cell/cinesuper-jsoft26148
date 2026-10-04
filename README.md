# 🎬 CineSuper — Mini OTT Movie Database

**Live Demo:** https://YOUR-USERNAME.github.io/cinesuper-YOUR-JSOFT-ID/

**Student:** YOUR NAME | **JSOFT ID:** YOUR JSOFT ID
**Institution:** Jain School of Future Technology
**Course:** Database Management Systems | **Faculty:** Sathish Kumar M

## Tech Stack
- Supabase (PostgreSQL) – database
- HTML, CSS, JavaScript – frontend
- GitHub Pages – hosting

## Database
- genres (id, name)
- movies (id, title, release_year, language, duration_min, description, poster_url, genre_id → genres)
- reviews (id, movie_id → movies, reviewer_name, rating 1–5, comment, created_at)
- View: movie_ratings (average rating per movie)
- SQL scripts: see the `database/` folder

## Features
- Browse, search and filter movies
- Movie details with reviews
- Add a review (saved to the database)
- Row Level Security enabled

## My Personalisation
- New movies added: …
- New column: …
- Extra feature: …