FROM golang:1.25.5-alpine3.23 as compiler

WORKDIR /webapp

COPY go.mod ./
RUN go mod download

COPY *.go ./

RUN GOOS=linux GOARCH=amd64 go build -o runner main.go

FROM scratch

COPY --from=compiler /webapp/runner /webapp/runner

EXPOSE 8085

CMD ["/webapp/runner"]