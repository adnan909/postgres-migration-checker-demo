CREATE TABLE orders (
  id         bigserial PRIMARY KEY,
  user_id    bigint NOT NULL REFERENCES users (id),
  total      numeric(12, 2) NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX orders_user_id_idx ON orders (user_id);
