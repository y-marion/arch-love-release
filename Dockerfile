FROM base/archlinux:latest

RUN pacman -Syy && \
  # Install love-release
  yes | pacman -S \
		git \
		gcc \
    libzip \
    luarocks5.1 && \
  luarocks-5.1 install lua-libzip && \
  luarocks-5.1 install love-release 2.0.8-1 && \
  # Install itch.io butler
  mkdir ~/bin && \
  curl https://broth.itch.ovh/butler/linux-amd64/LATEST/archive/default --output ~/bin/butler && \
  chmod 755 ~/bin/butler && \
  ~/bin/butler upgrade && \
	# Install ghr
	curl -L https://github.com/tcnksm/ghr/releases/download/v0.12.0/ghr_v0.12.0_linux_386.tar.gz | tar -xz --strip-components 1 && \
	mv ghr ~/bin && \
  chmod 755 ~/bin/ghr

ENV PATH="$PATH:~/bin"
