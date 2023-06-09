FROM golang:1.16

WORKDIR /go/src/github.com/Instabug/internship-2023

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN go build -o myapp

EXPOSE 9090

CMD ["./myapp"]