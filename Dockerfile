FROM golang:1.25-alpine AS builder

RUN apk add --no-cache upx

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o app .

RUN upx --best --lzma app

FROM scratch
COPY --from=builder app/app /app

ENTRYPOINT ["/app"]

