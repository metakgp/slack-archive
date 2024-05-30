# top-secret-stuff

Monorepo of top secret stuff developed in an n-sided polygonal building.

### Getting Started

#### Digester

1. Put your slack export inside the `digester` directory
2. Run `make digest FILE=<filename>`

#### Excretor

1. Install [Rust](https://www.rust-lang.org/tools/install).
2. Install [Docker](https://www.docker.com/get-started/) and [Docker Compose](https://docs.docker.com/compose/install/).
3. Make sure [GNU Make](https://www.gnu.org/software/make/) is installed.
4. Install [`cargo-watch`](https://github.com/watchexec/cargo-watch) to compile on change: `cargo install cargo-watch`.
5. Install [`sqlx-cli`](https://lib.rs/crates/sqlx-cli) for runtime checking of SQL queries: `cargo install sqlx-cli`.
6. Run `make dev`. Enjoy.
