FROM golang:alpine AS builder
RUN apk add --no-cache git
RUN git clone https://github.com/xqdoo00o/ChatGPT-to-API.git /cta
RUN cd cta && go build

FROM ubuntu
WORKDIR /cta
COPY --from=builder /cta/freechatgpt .
CMD [ "freechatgpt" ]
