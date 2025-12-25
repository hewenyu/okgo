FROM golang:1.24-alpine AS builder
WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o okgo

FROM alpine:3.21
WORKDIR /app

COPY --from=builder /app/okgo /usr/local/bin/okgo

EXPOSE 8080
ENTRYPOINT ["okgo"]
