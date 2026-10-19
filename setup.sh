#!/bin/bash

SERVER_DIR="mc_test_server"

read -p "Enter server software (paper, purpur, folia) [paper]: " SOFTWARE
SOFTWARE=${SOFTWARE:-paper}
SOFTWARE=$(echo "$SOFTWARE" | tr '[:upper:]' '[:lower:]')

read -p "Enter Minecraft version (e.g., 1.21.1) [1.21.1]: " MC_VERSION
MC_VERSION=${MC_VERSION:-1.21.1}

read -p "Enter RAM usage (e.g., 2G, 4G) [2G]: " RAM
RAM=${RAM:-2G}

echo "Creating server directory: $SERVER_DIR..."
mkdir -p "$SERVER_DIR"
cd "$SERVER_DIR" || exit

JAR_NAME="server.jar"
echo "Fetching latest build for $SOFTWARE $MC_VERSION..."

if [ "$SOFTWARE" == "paper" ] || [ "$SOFTWARE" == "folia" ]; then
    DOWNLOAD_URL=$(curl -s -H "User-Agent: LocalSetupScript/1.0" "https://fill.papermc.io/v3/projects/${SOFTWARE}/versions/${MC_VERSION}/builds" | jq -r '.[-1].downloads."server:default".url')
    
    if [ -z "$DOWNLOAD_URL" ] || [ "$DOWNLOAD_URL" == "null" ]; then
        echo "Error: Could not fetch build URL. Check if the version $MC_VERSION exists for $SOFTWARE."
        exit 1
    fi

elif [ "$SOFTWARE" == "purpur" ]; then
    DOWNLOAD_URL="https://api.purpurmc.org/v2/purpur/${MC_VERSION}/latest/download"
else
    echo "Error: Unsupported software '$SOFTWARE'. Use paper, purpur, or folia."
    exit 1
fi

echo "Downloading JAR from $DOWNLOAD_URL..."
curl -L -o "$JAR_NAME" "$DOWNLOAD_URL"

echo "Accepting the Minecraft EULA..."
echo "eula=true" > eula.txt

echo "Generating start.sh..."
cat << EOF > start.sh
#!/bin/bash
# Launching with Java 21 environment assumption
java -Xms$RAM -Xmx$RAM -jar $JAR_NAME nogui
EOF

chmod +x start.sh

echo "Setup complete in ./$SERVER_DIR!"
echo "To start it manually: cd $SERVER_DIR && ./start.sh"