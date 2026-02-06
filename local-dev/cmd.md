# First install homebrew brew https://brew.sh/
Then use brew to install 
- git [ generate ssh: ssh-keygen -t rsa -b 4096 ]
- composer and use composer to install laravel/valet https://laravel.com/docs/11.x/valet 
- php - php.ini is located in /opt/homebrew/etc/php/version/php.ini
- mysql
- ddev https://ddev.com/get-started/ 

# Install Prerequisites

## Install Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

===================================================================================================

## Clean volumes
```
brew cleanup
composer clear-cache
rm -rf ~/.config/valet/Log/*
rm -rf ~/Library/Caches/*
sudo rm -rf /Library/Caches/*
sudo rm -rf /private/var/log/*
sudo rm -rf ~/.Trash/*
npm cache clean --force
yarn cache clean
```

```
find . -name "._*" -delete
find . -name ".DS_Store" -delete
```

```
cd /usr/local/var/mysql Or: cd /opt/homebrew/var/mysql
rm -f binlog.* # except binlog.index
```

===================================================================================================

## To setup Apache

================================================================================================================
## Drupal 
1. change site/default permission:
    - chmod 755 sites/default 