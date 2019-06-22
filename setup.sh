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

# Install Powershell Universal Dashboard
pwsh -Command "& {Install-Module Universaldashboard.Community -Force -AcceptLicense}"

# Set baud rade, assuming device is ttyUSB0
sudo stty -F /dev/ttyUSB0 4800 # Not permanent?

# Install Syncthing
wget -O - https://syncthing.net/release-key.txt | sudo apt-key add -
echo "deb http://apt.syncthing.net/ syncthing release" | sudo tee -a /etc/apt/sources.list.d/syncthing-release.list
sudo apt update
sudo apt install syncthing -y

sudo reboot

# gpsd config
# in etc/default/gpsd, might be required to specify device with DEVICES="/dev/ttyUSB0"
