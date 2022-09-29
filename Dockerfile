FROM golang:1.17.11 AS builder
RUN mkdir -p /build
WORKDIR /build
ADD . .
RUN ls -lF
RUN CGO_ENABLED=0 go build

FROM alpine:3.13

RUN apk --no-cache upgrade && apk --no-cache add ca-certificates

COPY --from=builder /build/centrifugo /usr/local/bin/centrifugo 

WORKDIR /centrifugo

CMD ["centrifugo"]
