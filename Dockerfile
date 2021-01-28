FROM archlinux/base:latest

# Install love-release
RUN pacman -Syy && yes | pacman -S git gcc libzip luarocks tar love fakeroot dpkg
RUN luarocks install love-release
# Set up path
RUN mkdir -p /love-release/tmp
WORKDIR /love-release/tmp
# Download the itch.io butler
RUN curl -L -o butler.zip https://broth.itch.ovh/butler/linux-amd64/LATEST/archive/default && unzip -j butler.zip
# Download ghr
RUN curl -L https://github.com/tcnksm/ghr/releases/download/v0.13.0/ghr_v0.13.0_linux_386.tar.gz | tar -xz --strip-components 1
# Move binaries to ~/love-release
RUN mv butler /love-release && mv ghr /love-release
WORKDIR /love-release
# Clean up
RUN rm -rf tmp
# Make binaries executable
RUN chmod +x butler && chmod +x ghr
# Upgrade butler
RUN ./butler upgrade && ./butler -V

ENV PATH="$PATH:/love-release"
