#!/bin/bash

HOST="$1"
PORT=3306

echo "Aguardando banco de dados ($HOST:$PORT) ficar disponível..."

while ! nc -z "$HOST" "$PORT"; do
  echo "MySQL está indisponível - aguardando..."
  sleep 2
done

echo "MySQL está pronto!"
exec "${@:2}"
