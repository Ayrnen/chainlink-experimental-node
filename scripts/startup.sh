#!/usr/bin/env bash
set -euo pipefail

echo "⏳ Waiting for Postgres..."
until pg_isready -h postgres -U "${POSTGRES_USER}" >/dev/null 2>&1; do
  sleep 2
done
echo "✅ Postgres is up"

echo "🏗  Applying migrations..."
chainlink node migrate

echo "🔑 Ensuring admin user exists..."
if chainlink admin login --email "${CL_EMAIL}" --password "${CL_PASS}" >/dev/null 2>&1; then
  echo "✔️  Admin user logged in"
else
  chainlink admin create --email "${CL_EMAIL}" --password "${CL_PASS}" --first
  echo "✔️  Admin user created"
fi


echo "🚀 Starting Chainlink node..."
exec chainlink node run \
  -config /chainlink/config/chainlink-config.toml \
  -secrets /chainlink/config/cl-node.env