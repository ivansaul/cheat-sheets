---
title: Local Setup
icon: lucide/code
---

# Local Setup

The development environment consists of the Flutter mobile application and a local Cloudflare Worker backend.

!!! note "Prerequisites"
    Ensure you have [Flutter], [Rust], and [npm] installed on your system before proceeding.

  [Flutter]: https://flutter.dev/docs/get-started/install
  [Rust]: https://www.rust-lang.org/tools/install
  [npm]: https://docs.npmjs.com/getting-started/installing-node

## Backend Infrastructure

The mobile application fetches data from a DevStack Worker backend. You must spin up a local instance of this worker.

### Setup Worker

1. Clone the worker repository:

    ```bash
    git clone https://github.com/ivansaul/devstack-worker.git
    cd devstack-worker
    ```

2. Seed the local database:

    ```bash
    cargo run -p cheatsheets # (1)!
    ```

    1. Initial compilation may take a few minutes depending on your internet connection and Rust toolchain.

3. Launch the development server using `wrangler`:

    ```bash
    npx wrangler d1 execute CHEATSHEETS --local --file=./schema.sql
    npx wrangler dev --ip 0.0.0.0 --port 8787
    ```

Your local backend is now running at `http://localhost:8787`.

## Flutter Application

With the backend running, configure the mobile application.

### Setup App

1. Clone the main repository:

    ```bash
    git clone https://github.com/ivansaul/cheat-sheets.git
    cd cheat-sheets
    ```

2. Configure environment variables by creating `.env` and `.env_debug` in the root folder:

    ```ini
    API_CHEATSHEET_BASE_URL=http://localhost:8787/api # (1)!
    API_CHEATSHEET_LIST_ENDPOINT=/cheatsheets
    API_CHEATSHEET_DETAIL_ENDPOINT=/cheatsheets/:id
    
    API_COUPON_BASE_URL=https://cdn.real.discount/api
    API_COUPON_LIST_ENDPOINT=/courses
    API_COUPON_ENDPOINT=/courses/slug/:slug
    ```

    1. When testing on an Android Emulator, change this to your machine's local IP address (e.g., `http://192.168.41.100:8787/api`).

3. Install dependencies and run code generation:

    ```bash
    flutter pub get
    dart run build_runner watch -d
    ```

4. Launch the application:

    ```bash
    flutter run
    ```
