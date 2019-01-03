FROM base/archlinux:latest

RUN pacman -Syy && \
  # Install love-release
  yes | pacman -S \
    gcc \
    git \
    libzip \
    luarocks5.1 && \
  luarocks-5.1 install lua-libzip && \
  luarocks-5.1 install love-release && \
  luarocks-5.1 install loverocks && \
  # Install busted
  luarocks-5.1 install busted && \
  # Install itch.io butler
  mkdir ~/bin && \
  curl https://dl.itch.ovh/butler/linux-amd64/head/butler --output ~/bin/butler && \
  chmod 755 ~/bin/butler && \
  ~/bin/butler upgrade && \
	# Install ghr
	curl -L https://github.com/tcnksm/ghr/releases/download/v0.12.0/ghr_v0.12.0_linux_386.tar.gz | tar -xz --strip-components 1 && \
	mv ghr ~/bin && \
  chmod 755 ~/bin/ghr

ENV PATH="$PATH:~/bin"
