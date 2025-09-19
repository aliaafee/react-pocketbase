# React + Vite + Tailwindcss4 + PocketBase

## Installation

- npm install
- download https://github.com/pocketbase/pocketbase/releases
- extract pocketbase binary to ./pb/

Here’s a nicely formatted **Markdown version** of your Linux deployment instructions:

````markdown
## Deploy

### Linux Host

1. **Install prerequisites**

   ```bash
   sudo apt update
   sudo apt install -y git npm
   ```

2. **Create application directory**

   ```bash
   sudo mkdir -p /opt/react-pocketbase
   ```

3. **Create dedicated user**

   ```bash
   sudo useradd -r -s /usr/sbin/nologin -d /opt/react-pocketbase pbuser
   ```

4. **Fix permissions**

   ```bash
   sudo chown -R pocketbase:pocketbase /opt/react-pocketbase
   ```

5. **Clone repository**

   ```bash
   git clone https://github.com/aliaafee/react-pocketbase.git /opt/react-pocketbase
   ```

6. **Install dependencies**

   ```bash
   cd /opt/react-pocketbase
   npm install
   ```

7. **Download PocketBase binary**
   Get the latest release from [PocketBase releases](https://github.com/pocketbase/pocketbase/releases)
   Extract the binary to:

   ```bash
   /opt/react-pocketbase/pb/
   ```

8. **Configure environment (Optional)**
   Create a `.env` file in `/opt/react-pocketbase` with:

   ```env
   VITE_PB_BASE_URL="http://pocketbase.myhost.com:8090"
   ```

9. **Build frontend**

   ```bash
   npm run build
   ```

10. **Install systemd service**

    ```bash
    sudo cp /opt/react-pocketbase/scripts/pocketbase.service /etc/systemd/system/pocketbase.service
    ```

11. **Reload systemd and enable service**

    ```bash
    sudo systemctl daemon-reload
    sudo systemctl enable pocketbase.service
    sudo systemctl start pocketbase.service
    ```

12. **Check service status**

    ```bash
    systemctl status pocketbase.service
    ```
````
