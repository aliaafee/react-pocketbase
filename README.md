# React + Vite + Tailwindcss4 + PocketBase

## Installation

- npm install
- download https://github.com/pocketbase/pocketbase/releases
- extract pocketbase binary to ./pb/

## Deploy

### Linux Host

- checkout repository to /opt/react-pocketbase
- cd /opt/react-pocketbase
- npm install
- download pocketbase latest release from https://github.com/pocketbase/pocketbase/releases and extract pocketbase binary to /opt/react-pocketbase/pb/
- create .env file in /opt/react-pocketbase and the variable VITE_PB_BASE_URL="http://pocketbase.myhost.com:8090"
- npm run build
- npm run pb:serve
- TODO: Generate systemd service file
