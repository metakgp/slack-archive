FROM rust:slim-buster

WORKDIR /usr/src/myapp

# Copy all files
COPY Cargo.toml .
COPY . .

# Build the binary
RUN cargo build --release

# Copy metaploy configuration
COPY metaploy/archive.metaploy.conf /
COPY metaploy/postinstall.sh /

# Set the postinstall script as executable
RUN chmod +x /postinstall.sh

CMD ["/postinstall.sh", "target/release/excretor"]
