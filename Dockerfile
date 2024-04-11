FROM golang:1.18 AS builder

WORKDIR /app

COPY . .

RUN go mod init softcery.ua/softcery

RUN go mod tidy

RUN go get -u github.com/gin-gonic/gin

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main .

FROM alpine:latest  

RUN apk --no-cache add ca-certificates

WORKDIR /root/

COPY --from=builder /app/main .

EXPOSE 8080

CMD ["./main"]
