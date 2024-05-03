FROM golang:alpine AS builder
ENV CGO_ENABLED=0
RUN apk add --no-cache git ca-certificates tzdata
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone
RUN git clone https://github.com/xqdoo00o/ChatGPT-to-API.git /cta
RUN cd /cta && git reset --hard 89a038c3ca32bdbfdfcd2eff730aaaa9ff80ac7f
RUN go build

FROM scratch
ENV GIN_MODE=release
WORKDIR /cta
COPY --from=builder /cta/freechatgpt .
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /etc/localtime /etc/localtime
COPY --from=builder /etc/timezone /etc/timezone
CMD [ "./freechatgpt" ]
