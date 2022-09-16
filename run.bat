docker build --pull --rm -f "Dockerfile" -t sparkdocker:latest "."
docker-compose -f "docker-compose.yml" up -d --build 