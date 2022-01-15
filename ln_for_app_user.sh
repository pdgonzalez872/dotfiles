#! /bin/bash

sudo ln -s /usr/bin/whoami /home/app/bin/

# These are needed to run the Elixir release
sudo ln -s /usr/bin/readlink /home/app/bin
sudo ln -s /usr/bin/dirname /home/app/bin
sudo ln -s /usr/bin/cut /home/app/bin
sudo ln -s /usr/bin/sed /home/app/bin
sudo ln -s /usr/bin/cat /home/app/bin
sudo ln -s /usr/bin/grep /home/app/bin
sudo ln -s /usr/bin/basename /home/app/bin
