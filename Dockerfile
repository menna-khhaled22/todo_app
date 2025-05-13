# Dockerfile inside flutter_app/
FROM cirrusci/flutter:stable

WORKDIR /app

COPY . .

RUN flutter pub get

CMD ["flutter", "run"]
