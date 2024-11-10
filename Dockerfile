FROM golang:alpine AS builder

ENV XCADDY_SETCAP 0
ENV XCADDY_SKIP_CLEANUP 1

RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest

RUN xcaddy build \
    --with github.com/tailscale/caddy-tailscale@main \
    --output /usr/bin/caddy

FROM caddy:2.8.4
COPY --from=builder /usr/bin/caddy /usr/bin/caddy