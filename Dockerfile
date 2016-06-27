from    debian 
run     apt-get update && apt-get install -y \
                blackbox \
                curl \
                gettext \
                git \
                iceweasel \
                libgconf-2-4 \
                libicu52 \
                libnotify-bin \
                libnss3 \
                libunwind8 \
                x11vnc \
                xvfb

# Install Visual Studio Code
run     curl -o vscode-amd64.deb https://az764295.vo.msecnd.net/stable/fe7f407b95b7f78405846188259504b34ef72761/vscode-amd64.deb && \
	dpkg -i vscode-amd64.deb &&\
	rm vscode-amd64.deb

# Install dotnet core
run	curl -sSL -o dotnet.tar.gz https://go.microsoft.com/fwlink/?LinkID=809130 &&\
	mkdir -p /opt/dotnet && tar zxf dotnet.tar.gz -C /opt/dotnet &&\
	ln -s /opt/dotnet/dotnet /usr/local/bin


run	useradd -m coder -s /bin/bash

run	echo ' \
Xvfb :0 -screen 0 1440x960x24+32 & \
sleep 5 ;\ 
export DISPLAY=localhost:0 ;\
blackbox & \
xterm & \
x11vnc -passwd somepass ' >> /run.sh

run	chmod 777 /run.sh
cmd 	su coder -c "/run.sh"

