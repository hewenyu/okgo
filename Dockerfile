FROM golang:1.24-alpine AS builder
WORKDIR /app

COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o okgo

FROM alpine:3.20
WORKDIR /app

COPY --from=builder /app/okgo /usr/local/bin/okgo

RUN addgroup -g 1001 -S appgroup && adduser -u 1001 -S appuser -G appgroup
USER appuser

EXPOSE 8080
ENTRYPOINT ["okgo"]
