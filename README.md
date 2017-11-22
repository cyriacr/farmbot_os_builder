# farmbot_os_builder


This build script helps people who try to build your own RPi3 farmbot_os,
the script tested under Ubuntu 16.04.


  cd
  # prepare necessary libraries
  sudo apt-get install git curl wget nodejs npm -y
  git clone https://github.com/cyriacr/farmbot_os_builder
  ./farmbot_os_builder/build.sh

  # build firmware first
  ./scripts/build_firmware.sh

  # build nerves system
  # ignore git checkout before run clone_system.sh
  sed -i 's/git checkout/\# git checkout/g' ./scripts/clone_system.sh
  ./scripts/clone_system.sh rpi3
  ./scripts/build_system.sh rpi3

  # build release image, please replace 3.0.6 with your release number
  ./scripts/build_release_images.sh rpi3 3.0.6

  # sign release image, I didn't run this.
  #./scripts/sign_release.sh

