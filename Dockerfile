FROM golang:alpine AS builder
ENV CGO_ENABLED=0
RUN apk add --no-cache git
RUN git clone https://github.com/xqdoo00o/ChatGPT-to-API.git /cta
RUN cd /cta && go build

FROM alpine
ENV GIN_MODE=release
RUN apk --no-cache add ca-certificates
WORKDIR /cta
COPY --from=builder /cta/freechatgpt .
CMD [ "./freechatgpt" ]
