# Getting ready
sudo apt update

# Install gps daemon and clients
sudo apt install gpsd gpsd-clients -y

# Install pwsh on raspberry pi
sudo apt install libunwind8 -y
wget https://github.com/PowerShell/PowerShell/releases/download/v6.2.1/powershell-6.2.1-linux-arm32.tar.gz
mkdir ~/powershell
tar -xvf ./powershell-6.2.1-linux-arm32.tar.gz -C ~/powershell
sudo ln -s ~/powershell/pwsh /usr/bin/pwsh

# Set baud rade, assuming device is ttyUSB0
sudo stty -F /dev/ttyUSB0 4800 # Not permanent?
