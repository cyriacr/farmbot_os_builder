#!/bin/bash

# remove unwant files and packages before we start
rm -rf ~/.asdf
rm -rf farmbot

sudo apt-get autoremove -y
sudo apt-get remove elixir -y
sudo apt-get remove erlang -y

# install necessary tools
sudo apt-get install git curl -y

# install nodejs
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get update -y
sudo apt-get install -y nodejs

# install compile tools and asdf
sudo apt-get install ssh-askpass -y
sudo apt-get install git g++ libssl-dev libncurses5-dev bc m4 make unzip cmake python -y

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.3.0
echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bash_profile
echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bash_profile

# install erlang and elixir
source ~/.bash_profile
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf install erlang 19.3
asdf install elixir 1.4.2
asdf global erlang 19.3
asdf global elixir 1.4.2
mix local.hex
mix local.rebar
mix archive.install hex nerves_bootstrap
mix local.nerves

wget https://github.com/fhunleth/fwup/releases/download/v0.17.0/fwup_0.17.0_amd64.deb -O fwup_0.17.0_amd64.deb
sudo dpkg -i fwup_0.17.0_amd64.deb

# get farmbot_os
mkdir farmbot; cd farmbot
git clone https://github.com/FarmBot/farmbot_os.git os
cd os
npm install
npm run build

# build image
export MIX_ENV=prod
export MIX_TARGET=rpi3
source ~/.bash_profile
sudo rm /tmp/apt-* -f
mix deps.get
mix firmware
