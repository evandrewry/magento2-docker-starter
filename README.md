This is a docker-compose configuration to run magento 2 with: 

- persistent file storage on the host machine via shared volumes
- an external database server (in the cloud, running on the host machine, in another docker container you set up yourself, etc)
- a cron container that runs the magento cron jobs
- a cli container that can be attached to and has standard magento tooling installed (composer, magedbm, n98-magerun)

Mac Usage
=========

Mac recommended for development only! docker for mac is very slow for the volume sharing magento needs to persist files

Homebrew installation:

    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

Docker for Mac installation:

    brew uninstall docker docker-machine docker-compose #remove all docker stuff if already installed
    brew cask install docker #install Docker for Mac
    open /Applications/Docker.app #and follow setup instructions


To run:

    docker-compose up #images will build and you will eventually get apache running on localhost:80


Magento Installation
====================

The first time we run magento (and every time we add new dependencies) we will need to install them with composer

While docker-compose is running, to attach to the magento cli container (where composer is installed):

    docker exec -it magento2starter_cli_1 /bin/bash

When you attach to the container you will already be in the magento web dir. To install the magento dependencies with composer:

    composer install #The first time, you will need to make a magento marketplace account and enter your API keys when prompted

Now, open your browser to http://localhost/setup and follow the instuctions to install magento 2. You will need an external mysql server running, as this docker configuration does not provide a local mysql, and you will need to enter your mysql login credentials in the magento setup wizard.

