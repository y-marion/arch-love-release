FROM base/archlinux:latest

RUN pacman -Sy && \
  # Install love-release
  yes | pacman -S \
		git \
		gcc \
    libzip \
    luarocks5.1 && \
  luarocks-5.1 install lua-libzip && \
	# Install an old version of love-release because pacman's luarocks doesn't support Rockspec format 3.0 yet
  luarocks-5.1 install love-release 2.0.8-1 && \
	# Set up path
  mkdir ~/bin && \
	cd ~/bin && \
  # Install itch.io butler
  curl -L -o butler.zip https://broth.itch.ovh/butler/linux-amd64/LATEST/archive/default && \
	unzip -j butler.zip && \
  chmod +x butler && \
  butler upgrade && \
	butler -V && \
	# Install ghr
	curl -L https://github.com/tcnksm/ghr/releases/download/v0.12.0/ghr_v0.12.0_linux_386.tar.gz | tar -xz --strip-components 1 && \
  chmod +x ghr

ENV PATH="$PATH:~/bin"
