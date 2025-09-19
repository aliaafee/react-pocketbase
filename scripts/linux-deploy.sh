#!/bin/bash
set -euo pipefail

# --- 1. Install prerequisites ---
echo "[*] Installing prerequisites..."
sudo apt update
sudo apt install -y git npm curl unzip

# --- 2. Create application directory ---
echo "[*] Creating application directory..."
sudo mkdir -p /opt/react-pocketbase

# --- 3. Create dedicated user ---
echo "[*] Creating pbuser..."
if ! id "pbuser" &>/dev/null; then
    sudo useradd -r -s /usr/sbin/nologin -d /opt/react-pocketbase pbuser
fi

# --- 4. Fix permissions ---
echo "[*] Setting ownership..."
sudo chown -R pbuser:pbuser /opt/react-pocketbase

# --- 5. Clone repository ---
echo "[*] Cloning repository..."
if [ ! -d "/opt/react-pocketbase/.git" ]; then
    sudo -u pbuser git clone https://github.com/aliaafee/react-pocketbase.git /opt/react-pocketbase
else
    echo "Repo already cloned, skipping."
fi

# --- 6. Install dependencies ---
echo "[*] Installing npm dependencies..."
cd /opt/react-pocketbase
sudo -u pbuser npm install

# --- 7. Download PocketBase binary ---
echo "[*] Downloading latest PocketBase release..."
PB_DIR="/opt/react-pocketbase/pb"
sudo -u pbuser mkdir -p "$PB_DIR"
LATEST_URL=$(curl -s https://api.github.com/repos/pocketbase/pocketbase/releases/latest \
    | grep "browser_download_url.*linux_amd64.zip" \
    | cut -d '"' -f 4 | head -n1)

if [ -z "$LATEST_URL" ]; then
    echo "Could not fetch PocketBase release URL. Exiting."
    exit 1
fi

TMPFILE=$(mktemp)
curl -L "$LATEST_URL" -o "$TMPFILE"
sudo -u pbuser unzip -o "$TMPFILE" -d "$PB_DIR"
rm "$TMPFILE"

# # --- 8. Configure environment (optional) ---
# echo "[*] Creating .env file..."
# if [ ! -f "/opt/react-pocketbase/.env" ]; then
#     cat <<EOF | sudo tee /opt/react-pocketbase/.env >/dev/null
# VITE_PB_BASE_URL="http://pocketbase.myhost.com:8090"
# EOF
#     sudo chown pbuser:pbuser /opt/react-pocketbase/.env
# fi

# --- 9. Build frontend ---
echo "[*] Building frontend..."
sudo -u pbuser npm run build

# --- 10. Install systemd service ---
echo "[*] Installing systemd service..."
if [ -f "/opt/react-pocketbase/scripts/pocketbase.service" ]; then
    sudo cp /opt/react-pocketbase/scripts/pocketbase.service /etc/systemd/system/pocketbase.service
else
    echo "Warning: pocketbase.service file not found in scripts/"
fi

# --- 11. Reload systemd and enable service ---
echo "[*] Enabling and starting PocketBase service..."
sudo systemctl daemon-reload
sudo systemctl enable pocketbase.service
sudo systemctl start pocketbase.service

echo "[✓] Deployment complete!"
