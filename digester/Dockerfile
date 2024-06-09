FROM golang:1.22.3-alpine AS builder

WORKDIR /app
RUN apk add --no-cache build-base
COPY . .
RUN go mod download && \
    go build -o app .

FROM alpine:latest

WORKDIR /app
COPY --from=builder /app/app .
ARG ZIPFILE_PATH
COPY ${ZIPFILE_PATH} /slack-export.zip
ENV ZIPFILE_PATH=/slack-export.zip
EXPOSE 8080
CMD ["./app"]