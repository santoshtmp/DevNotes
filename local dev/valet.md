# First install homebrew brew https://brew.sh/
Then use brew to install 
- git [ generate ssh: ssh-keygen -t rsa -b 4096 ]
- composer and use composer to install laravel/valet https://laravel.com/docs/11.x/valet 
- php - php.ini is located in /opt/homebrew/etc/php/version/php.ini
- mysql

# Install Prerequisites

## Install Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

---
===================================================================================================

# Valet

## Install Composer
- brew install composer
- brew install php
- brew install mysql

## Step 1: Install Valet globally via Composer
- composer global require laravel/valet

## Add Composer's global bin to PATH (add to ~/.zshrc or ~/.bash_profile too)
- export PATH="$PATH:$HOME/.composer/vendor/bin"

## Install Valet
- valet install

## Stop automtically start of valet dnsmasq, 
- sudo brew services stop dnsmasq
- sudo brew services stop nginx
- sudo brew services stop php
- valet status

## Now to start and stop valet sites
- valet restart
- valet stop

## To list all brew services
brew services list

## Step 2: Create Projects Directory and Park with Valet
- mkdir ~/Sites
- cd ~/Sites
- valet park

## step3: Create project dir and project inside Sites dir like
- wordpress
- drupal
- moodle
- santoshmagar

To make secure site: valet secure project_name 


## step4: Database
Also check ```db.md``` for database

### MySQL
- brew install mysql  
- brew install phpmyadmin
- then create symlink, So we can access phpmyadmin through phpmyadmin.test when valet is running: 
    - ln -s /opt/homebrew/opt/phpmyadmin/share/phpmyadmin  ~/Sites/phpmyadmin

### PostgresSQL
- brew install postgresql
- brew services start postgresql
- brew services list
- brew install --cask tableplus :: For GUI Table view


## check all installed php : 
 - brew list | grep php

## install version: 
- brew install php@8.2
- brew reinstall php@8.2
- brew link php@8.2
- brew cleanup
- brew unlink php
- brew unlink php@8.2

- sudo pkill php-fpm
- brew services start php@8.3
- valet restart

valet use php@8.1
Note that you might need to run "composer global update" if your PHP version change affects the dependencies of global packages required by Composer.

#### Isolate a project to PHP 8.1:
- cd ~/Sites/your-project
- valet isolate php@8.1
- valet unisolate
- Then check the site, and php used within the site.



