# Local Minecraft Server Automation

A collection of bash scripts to instantly start, enable, and delete a local Minecraft test server (Paper, Purpur, or Folia). Made for rapid plugin development and testing.

### ⚠️ Important Warnings
* **OS Compatibility:** These scripts are specifically designed for and only guaranteed to work on **Linux** systems. TI cannot guaranteed and will not worry about making this work on Windows or MacOS.
* **Automatic EULA Acceptance:** By running these scripts, you are automatically agreeing to the [Minecraft EULA](https://www.minecraft.net/en-us/eula). The setup script automatically generates the `eula=true` file required to boot the server.

---

## 🛠️ Requirements
* **Java:** You must have Java installed (Java 21 is recommended for modern Minecraft versions).
* **jq:** Required for parsing the PaperMC API. Install it via your package manager (e.g., `sudo apt install jq`).
* **curl:** Required for downloading the server jars.

## 🚀 How to Use

### 1. The Interactive Setup (`setup.sh`)
Creates a new `mc_test_server` directory, downloads the specified software/version, accepts the EULA, and creates a `start.sh` file.
```bash
./setup.sh
```
*It will prompt you for the software (paper/purpur/folia), Minecraft version (e.g., 1.21.1), and RAM allocation. Leave blank and press Enter to use the defaults.*

### 2. The One-Click Auto Boot (`auto_boot.sh`)
Bypasses the prompts in `setup.sh` by automatically accepting the default values, then immediately launches the server. 
```bash
./auto_boot.sh
```
*This is the fastest way to get a fresh Paper server running from scratch.*

### 3. The Clean Wipe (`wipe.sh`)
Finds the active Java process running specifically in the `mc_test_server` directory, safely forcefully kills it, and completely deletes the server folder.
```bash
./wipe.sh
```
*Use this when you are done testing and want to clean up your workspace. It will not affect anything outside the test directory.*