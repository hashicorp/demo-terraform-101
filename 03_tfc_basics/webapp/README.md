# Web app

A web app written in Go that uses websockets to log visits and push notifications to all visitors.

Defaults to running on port 80. Set `PORT` as ENV var to specify another port.

### Build

Build for Linux and Darwin:

    ./bin/build

Output can be found in `dist`.

A copy of the Linux executable will also be copied to `../assets` for deployment with Terraform.

### Run

    PORT=8080 go run main.go

### View

    http://localhost:8080

## Credits

Browser icons from https://github.com/alrra/browser-logos


