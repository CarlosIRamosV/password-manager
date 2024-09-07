FROM rust:alpine AS dependencies
WORKDIR /usr/src
COPY Cargo.toml ./
COPY crates/common ./crates/common
RUN apk add musl-dev
RUN cargo build --release

FROM dependencies AS builder
COPY crates/account ./crates/account
RUN cargo build --release --package account

FROM alpine:latest AS runtime
WORKDIR /usr/src
COPY --from=builder /usr/src/target/release/account /usr/src/account
ENV RUST_LOG=info
ENV HOST=0.0.0.0
ENV PORT=80
EXPOSE 80
CMD ["./account"]