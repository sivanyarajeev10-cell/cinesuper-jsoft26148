-- SCRIPT 1: CREATE TABLES
-- Phase 3: Create database tables

create table genres (
  id   bigint generated always as identity primary key,
  name text not null unique
);

create table movies (
  id           bigint generated always as identity primary key,
  title        text not null,
  release_year int  check (release_year between 1900 and 2100),
  language     text not null,
  duration_min int  check (duration_min > 0),
  description  text,
  poster_url   text,
  genre_id     bigint references genres(id) on delete set null,
  created_at   timestamptz default now()
);

create table reviews (
  id            bigint generated always as identity primary key,
  movie_id      bigint not null references movies(id) on delete cascade,
  reviewer_name text not null,
  rating        int  not null check (rating between 1 and 5),
  comment       text,
  created_at    timestamptz default now()
);