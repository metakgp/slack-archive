FROM golang:1.22.3-alpine

WORKDIR /app

RUN apk add build-base

COPY . /app

ARG ZIPFILE_PATH

COPY ${ZIPFILE_PATH} /app/slack-export.zip

ENV ZIPFILE_PATH=/app/slack-export.zip

RUN go mod download

RUN go build -o app .

EXPOSE 8080

CMD ./app