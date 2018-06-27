FROM golang:1.10.3-alpine3.7 AS build
ENV SERVICE go-server
RUN apk update && apk add gcc musl-dev
ADD . /go/src/github.com/chiswicked/${SERVICE}
WORKDIR /go/src/github.com/chiswicked/${SERVICE}
RUN go get -v -t -d ./...
RUN go build -o ${SERVICE} -a .

FROM alpine:3.7
ENV SERVICE go-server
RUN mkdir /app
COPY --from=build /go/src/github.com/chiswicked/${SERVICE}/${SERVICE} /app
EXPOSE 8888
CMD ["/app/go-server"]
