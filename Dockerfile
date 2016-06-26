
from    pyromanic/jessie:2.0
# make sure the package repository is up to date
run     apt-get update

# Install vnc, xvfb in order to create a 'fake' display and firefox
run     apt-get install -y x11vnc xvfb iceweasel blackbox curl git

# Some additional packages required to run code
run	apt-get install -y libunwind8 libicu52

# Install Visual Studio Code
run     curl -o vscode-amd64.deb https://az764295.vo.msecnd.net/stable/fe7f407b95b7f78405846188259504b34ef72761/vscode-amd64.deb
run	dpkg -i vscode-amd64.deb

# Some additional packages required to run code
run	apt-get install -y gettext

# Install dotnet core
run	mkdir /usr/local/dotnet
run	curl -sSL https://raw.githubusercontent.com/dotnet/cli/rel/1.0.0-preview1/scripts/obtain/dotnet-install.sh | bash /dev/stdin --version 1.0.0-preview1-002702 --install-dir /usr/local/dotnet

# Some additional packages required to run code
run	apt-get install -y libnotify-bin
run	apt-get install -y libgconf-2-4
run	apt-get install -y libnss3

run	useradd -m coder -s /bin/bash

run	ln -s /usr/local/dotnet/dotnet /usr/local/bin

run	echo "Xvfb &" > /run.sh
run	echo "sleep 5; export DISPLAY=localhost:0; blackbox & xterm &" >> /run.sh
run	chmod 777 /run.sh
run	echo "x11vnc -passwd somepass" >> /run.sh
cmd 	su coder -c "/run.sh"

