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
- brew services list :: To check brew services
- brew services restart httpd :: To restart httpd apache
- Listen 8080 in httpd.conf :: To change apache to port 8080 as valet is runnig in 80 
- URL http://localhost:8080
- DocumentRoot "/opt/homebrew/var/www"

### As apache is not loading php then follow the steps
- brew list | grep php :: To list the available php version in your machine
- Uncomment/add followiing in /opt/homebrew/etc/httpd/httpd.conf : LoadModule php_module /opt/homebrew/opt/php/lib/httpd/modules/libphp.so
```
<FilesMatch \.php$>
    SetHandler application/x-httpd-php
</FilesMatch>
DocumentRoot "/opt/homebrew/var/www"
<Directory "/opt/homebrew/var/www">
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
</Directory>
<IfModule dir_module>
    DirectoryIndex index.html index.php
</IfModule>
```
- Make sure mod_rewrite is loaded in httpd.conf : LoadModule rewrite_module lib/httpd/modules/mod_rewrite.so
