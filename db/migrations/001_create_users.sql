CREATE TABLE users (
  id         bigserial PRIMARY KEY,
  email      text NOT NULL UNIQUE,
  name       text,
  created_at timestamptz NOT NULL DEFAULT now()
);
