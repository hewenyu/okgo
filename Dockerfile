FROM golang:1.22-alpine AS builder
WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o okgo

FROM alpine:3.20
WORKDIR /app

COPY --from=builder /app/okgo /usr/local/bin/okgo

EXPOSE 8080
ENTRYPOINT ["okgo"]
