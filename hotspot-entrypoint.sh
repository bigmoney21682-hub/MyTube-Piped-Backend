#!/usr/bin/env sh
set -e

# Render provides DATABASE_URL
# Piped expects JDBC_DATABASE_URL
if [ -n "$DATABASE_URL" ] && [ -z "$JDBC_DATABASE_URL" ]; then
  export JDBC_DATABASE_URL="$DATABASE_URL"
fi

MAX_MEMORY=${MAX_MEMORY:-1G}

exec java \
  -server \
  -Xmx"$MAX_MEMORY" \
  -XX:+UnlockExperimentalVMOptions \
  -XX:+HeapDumpOnOutOfMemoryError \
  -XX:+OptimizeStringConcat \
  -XX:+UseStringDeduplication \
  -XX:+UseCompressedOops \
  -XX:+UseNUMA \
  -XX:+UseG1GC \
  -jar /app/piped.jar
