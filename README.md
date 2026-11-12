# Postgres migration safety check: demo

A tiny project with the free [Postgres Migration Safety Check](https://github.com/marketplace/actions/postgres-migration-safety-check) GitHub Action already set up. Every pull request that changes a file in `db/migrations/` is checked for statements that lock or rewrite a live table, fail on a table that has data, or break the app while it deploys. Risky lines get marked in the diff, and one comment shows a safe version of each.

**See it working:** open the [pull requests](../../pulls). The open one adds a single "harmless" migration, and the check explains why each line would hurt on a big table.

## Try it yourself in 30 seconds
1. Click **Use this template** (top right) to copy this repo to your account.
2. In your copy, edit `db/migrations/`: add a file like `003_test.sql` with
   ```sql
   CREATE INDEX users_created_at_idx ON users (created_at);
   ```
   and open a pull request.
3. The check runs in about 10 seconds and comments with the safe version (`CREATE INDEX CONCURRENTLY`).

## Add it to your real project
Copy [`.github/workflows/migrations.yml`](.github/workflows/migrations.yml) into your repo and set `files:` to wherever your migrations live, for example `prisma/migrations/*/migration.sql` or `supabase/migrations/*.sql`. It works with any tool that keeps migrations as SQL files (Prisma, Supabase, Flyway, golang-migrate, dbmate, node-pg-migrate and more), needs no account, and works on private repos.

Options (fail level, transactions, comments): [action README](https://github.com/adnan909/postgres-migration-checker#use-it-in-ci-github-action).
Prefer to check one file by hand? Paste it into the [browser checker](https://adnan909.github.io/postgres-migration-checker/).

## What it catches
Plain `CREATE INDEX`, volatile `DEFAULT` that rewrites the table, `ADD COLUMN ... NOT NULL` with no default, `ALTER COLUMN ... TYPE`, `SET NOT NULL`, foreign keys and checks without `NOT VALID`, unique constraints without a concurrent index, renames and drops during a rolling deploy, `CONCURRENTLY` inside a transaction, big `UPDATE` backfills, and a missing `lock_timeout`. Each finding explains why it hurts and shows the safe version. Rules were verified against PostgreSQL 16.

---
Made by [@backendskills00](https://x.com/backendskills00). Want Claude Code to write migrations like this in the first place? Try the free [postgres-safe-migrations skill](https://github.com/adnan909/free-sample).
