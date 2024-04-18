FROM golang:alpine AS builder
ENV CGO_ENABLED=0
ENV GIN_MODE=release
RUN apk add --no-cache git
RUN git clone https://github.com/xqdoo00o/ChatGPT-to-API.git /cta
RUN cd /cta && go mod download && go build -o /cta/ChatGPT-To-API .

FROM scratch
WORKDIR /cta
COPY --from=builder /cta/ChatGPT-To-API .
CMD [ "./ChatGPT-To-API" ]
