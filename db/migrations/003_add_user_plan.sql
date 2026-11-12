-- Add billing plan and an API token to every user.
ALTER TABLE users ADD COLUMN plan text NOT NULL;
ALTER TABLE users ADD COLUMN api_token uuid DEFAULT gen_random_uuid();
CREATE INDEX users_plan_idx ON users (plan);
ALTER TABLE orders ADD CONSTRAINT orders_total_positive CHECK (total > 0);
