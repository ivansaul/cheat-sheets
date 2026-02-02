# Development

This guide provides instructions on how to setup and run the project.

## Prerequisites

Ensure you have the following installed:

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Rust](https://www.rust-lang.org/tools/install)
- [npm](https://docs.npmjs.com/getting-started/installing-node)

## Setup

1. Clone the worker repository

    ```bash
    git clone https://github.com/ivansaul/devstack-worker.git
    ```

2. Run the seed script to create the database

    ```bash
     cargo run -p cheatsheets
    ```

3. Start the development server

    ```bash
    npx wrangler d1 execute CHEATSHEETS --local --file=./schema.sql
    ```

    ```bash
    npx wrangler dev --ip 0.0.0.0 --port 8787
    ```

4. Clone the cheat-sheets repository

    ```bash
    git clone https://github.com/ivansaul/cheat-sheets.git
    ```

5. Configure environment variables

    Create a `.env` and `.env_debug` files in the root of the project and add the following:

    ```console
    # For android emulator
    # API_CHEATSHEET_BASE_URL=http://YOUR_IP:8787/api
    API_CHEATSHEET_BASE_URL=http://localhost:8787/api
    API_CHEATSHEET_LIST_ENDPOINT=/cheatsheets
    API_CHEATSHEET_DETAIL_ENDPOINT=/cheatsheets/:id
    API_COUPON_BASE_URL=https://cdn.real.discount/api
    API_COUPON_LIST_ENDPOINT=/courses
    API_COUPON_ENDPOINT=/courses/slug/:slug
    ```

6. Run the app

   ```bash
   flutter pub get
   dart run build_runner watch -d
   flutter run
   ```
