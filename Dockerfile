FROM golang:alpine AS builder
ENV CGO_ENABLED=0
RUN apk add --no-cache git ca-certificates
RUN git clone https://github.com/xqdoo00o/ChatGPT-to-API.git /cta
RUN cd /cta && go build

FROM scratch
ENV GIN_MODE=release
WORKDIR /cta
COPY --from=builder /cta/freechatgpt .
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
CMD [ "./freechatgpt" ]
