
# Automated Wireless Network Deauthentication Script

This Bash script automates the process of deauthenticating clients from a specific wireless access point. It utilizes various tools from the Aircrack-ng suite to perform wireless network analysis and deauthentication attacks.

![ ](https://github.com/adithyanraj03/Automated-Wifi-DDOS-Script/blob/main/data/Screenshot%20at%202024-12-07%2013-40-50.png)

## Features

- 🔍 Automatically detects and terminates interfering processes
- 📡 Enables monitor mode on the specified wireless interface
- 🎯 Scans for the target access point based on BSSID and SSID
- 📊 Extracts the operating channel of the target access point
- 💥 Performs a deauthentication attack on all connected clients

  ![ ](https://github.com/adithyanraj03/Automated-Wifi-DDOS-Script/blob/main/data/Screenshot%20at%202024-12-07%2013-41-35.png)
## Prerequisites

Before using this script, ensure you have the following:

- 🐧 A Linux-based operating system
- 🛠️ Aircrack-ng suite installed
- 🔑 Root privileges or sudo access
- 📶 A wireless network adapter capable of packet injection

## Usage

1. Edit the script to set the following variables:
   - `INTERFACE`: Your wireless network interface name
   - `BSSID`: The MAC address of the target access point
   - `SSID`: The SSID of the target network

2. Make the script executable:
   ```bash
   chmod +x deauth_script.sh
   ```

3. Run the script with root privileges:
   ```bash
   sudo ./deauth_script.sh
   ```

## Script Workflow

1. Checks and terminates interfering processes
2. Enables monitor mode on the specified interface
3. Scans for wireless networks using airodump-ng
4. Identifies the target network based on BSSID and SSID
5. Extracts the operating channel of the target network
6. Sets the wireless interface to the target channel
7. Initiates a deauthentication attack on all connected clients

## Disclaimer

⚠️ This script is intended for educational and ethical testing purposes only. Unauthorized use of this script against networks you do not own or have explicit permission to test is illegal and unethical. Always obtain proper authorization before performing any network security assessments.


## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

For questions or feedback, feel free to reach out:
