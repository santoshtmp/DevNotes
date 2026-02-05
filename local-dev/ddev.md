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

---
===================================================================================================

# DDEV

### Install OrbStack Docker Provider
```
brew install orbstack docker
docker version
brew install ddev/ddev/ddev
ddev -v
mkcert -install
```

#### Create a Project
```
cd ~/dev/my-project
ddev config
ddev start
ddev launch
ddev restart
ddev describe
ddev stop
ddev delete
```

### Chnage PHP verson
- Edit .ddev/config.yml and restart ddev ``` ddev restart ```
##### Increase PHP Limits (Memory, Upload Size, Execution Time)
- Create custom PHP config
```
mkdir -p .ddev/php
nano .ddev/php/php.ini
```
- And add php congig settings
```
memory_limit = 1024M
upload_max_filesize = 256M
post_max_size = 256M
max_execution_time = 300
max_input_vars = 5000
```

### Export Import DB
```
ddev export-db --file=db.sql.gz  
ddev export-db --database=santoshdb --file=santoshdb.sql.gz 
ddev import-db --file=db.sql.gz  
ddev import-db --database=santoshdb --file=santoshdb.sql.gz 
```

### Change webserver
- Edit .ddev/config.yml and restart ddev ``` ddev restart ```

### Check space usage
``` docker system df ```

### After deleting Cleanup
- Remove unused DDev project containers
``` ddev delete -Oy ```
(-O = remove data, -y = no prompt)

- Clean unused Docker resources (recommended)
``` docker system prune ```

- Remove unused Volumes contain databases — only do this if you don’t need old DBs. (THIS frees the most space)
``` docker volume prune ```

- Full cleanup Removes everything unused (images + volumes + cache)
``` docker system prune -a --volumes ```


