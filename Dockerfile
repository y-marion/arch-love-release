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
  curl -L https://broth.itch.ovh/butler/linux-amd64/LATEST/archive/default > ~/bin/butler.zip && \
	unzip -j ~/bin/butler.zip && \
	ls -la ~/bin && \
  chmod 755 ~/bin/butler && \
  ~/bin/butler upgrade && \
	~/bin/butler -V && \
	# Install ghr
	curl -L https://github.com/tcnksm/ghr/releases/download/v0.12.0/ghr_v0.12.0_linux_386.tar.gz > ~/bin/ghr.tar.gz && \
	tar -xz --strip-components 1 ~/bin/ghr.tar.gz && \
  chmod 755 ~/bin/ghr

ENV PATH="$PATH:~/bin"
