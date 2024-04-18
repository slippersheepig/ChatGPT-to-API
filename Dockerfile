FROM golang:alpine AS builder
ENV CGO_ENABLED=0
RUN apk add --no-cache git
RUN git clone https://github.com/xqdoo00o/ChatGPT-to-API.git /cta
RUN cd /cta && go mod download && go build

FROM scratch
ENV GIN_MODE=release
WORKDIR /cta
COPY --from=builder /cta/freechatgpt .
CMD [ "./freechatgpt" ]
