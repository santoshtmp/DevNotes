# Complete Guide to Setting Up Apache with Virtual Hosts for Local Development

This guide provides step-by-step instructions for setting up Apache with virtual hosts for local development domains like `santoshmagar.test`.

## Step 1: Install Apache via Homebrew

First, make sure you have Homebrew installed, then install Apache:

```bash
brew install httpd
```

## Step 2: Configure Apache Main Configuration

1. Open the main Apache configuration file:
```bash
sudo nano /opt/homebrew/etc/httpd/httpd.conf
```

2. Find and uncomment the line that includes virtual host configurations (remove the # symbol):
```
Include /opt/homebrew/etc/httpd/extra/httpd-vhosts.conf
```

3. Set the main document root (optional, but recommended):
```
DocumentRoot "/opt/homebrew/var/www"
<Directory "/opt/homebrew/var/www">
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
</Directory>
```

4. Add PHP support:

First, check what PHP version is installed on your machine:
```bash
brew list | grep php
```

Then add the appropriate configuration. If Apache is not loading PHP, uncomment/add the following in `/opt/homebrew/etc/httpd/httpd.conf`:

Option 1 (Generic PHP path):
```
LoadModule php_module /opt/homebrew/opt/php/lib/httpd/modules/libphp.so
<FilesMatch \.php$>
    SetHandler application/x-httpd-php
</FilesMatch>
AddHandler php-script .php
<IfModule dir_module>
    DirectoryIndex index.html index.php
</IfModule>
```

Option 2 (Specific PHP version - replace 8.3 with your version):
```
LoadModule php_module /opt/homebrew/opt/php@8.3/lib/httpd/modules/libphp.so
<FilesMatch \.php$>
    SetHandler application/x-httpd-php
</FilesMatch>
AddHandler php-script .php
<IfModule dir_module>
    DirectoryIndex index.html index.php
</IfModule>
```

To determine which path is correct for your system, check which file exists:
```bash
ls -la /opt/homebrew/opt/php/lib/httpd/modules/libphp.so
ls -la /opt/homebrew/opt/php@8.3/lib/httpd/modules/libphp.so
```

Use the path that corresponds to the file that exists on your system.

5. Make sure mod_rewrite is loaded in httpd.conf (this is often necessary for many web applications):
```
LoadModule rewrite_module lib/httpd/modules/mod_rewrite.so
```
This module enables URL rewriting capabilities which many web applications require.

## Step 6: Configure Virtual Host for santoshmagar.test or anyother site

1. Open the virtual hosts configuration file:
```bash
sudo nano /opt/homebrew/etc/httpd/extra/httpd-vhosts.conf
```

2. Add the virtual host configuration for `santoshmagar.test`:
```
# Virtual Host for santoshmagar.test
<VirtualHost *:80>
    ServerName santoshmagar.test
    DocumentRoot "/opt/homebrew/var/www/santoshmagar"
    <Directory "/opt/homebrew/var/www/santoshmagar">
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
    ErrorLog "/opt/homebrew/var/log/httpd/santoshmagar_error.log"
    CustomLog "/opt/homebrew/var/log/httpd/santoshmagar_access.log" common
</VirtualHost>
```

## Step 7: Create Document Root Directory

Create the directory for your website:

```bash
sudo mkdir -p /opt/homebrew/var/www/santoshmagar
```

## Step 8: [OPTIONAL] Create Symlink to Real Project Directory

Instead of copying files to the Apache document root, you can create a symbolic link to your actual project directory:

```bash
ln -s /Users/santosh/projects/santoshmagar /opt/homebrew/var/www/santoshmagar
```

Replace `/Users/santosh/projects/santoshmagar` with the path to your actual project directory. This way, any changes you make in your project directory will be reflected immediately in your local development site without needing to copy files.

## Step 9: Add Domain to Hosts File

1. Edit the hosts file:
```bash
sudo nano /etc/hosts
```

2. Add the domain mapping at the end of the file:
```
# Local development domains
127.0.0.1    santoshmagar.test
```

3. Save and exit: Press `Ctrl+X`, then `Y` to confirm saving, then `Enter` to confirm the filename.

## Step 10: Check Brew Service Status

Check if Apache service is running:
```bash
brew services list
# OR
brew services list | grep httpd
```

## Step 11: Check Apache Status

Get detailed information about Apache service:
```bash
brew services info httpd
```

## Step 12: Start Apache Service

Start the Apache service:
```bash
brew services start httpd
```

## Step 13: Stop Apache Service

Stop the Apache service:
```bash
brew services stop httpd
```

## Step 14: Restart Apache Service

Restart the Apache service:
```bash
brew services restart httpd
```

## Step 15: Alternative Apache Control Commands

Instead of using brew services, you can also use Apache's built-in commands:

Start Apache:
```bash
sudo /opt/homebrew/bin/apachectl start
```

Stop Apache:
```bash
sudo /opt/homebrew/bin/apachectl stop
```

Restart Apache:
```bash
sudo /opt/homebrew/bin/apachectl restart
```

Check Apache configuration for errors:
```bash
sudo /opt/homebrew/bin/apachectl configtest
```

## Step 16: Flush DNS Cache

To ensure the changes take effect immediately, flush your DNS cache:
```bash
sudo dscacheutil -flushcache
```

Or alternatively:
```bash
sudo killall -HUP mDNSResponder
```

## Step 17: Test Your Setup

After completing these steps, you'll be able to access your local site at:
- http://santoshmagar.test

## Step 18: Troubleshooting

1. If Apache won't start, check the configuration:
```bash
sudo /opt/homebrew/bin/apachectl configtest
```

2. Check Apache error logs:
```bash
tail -f /opt/homebrew/var/log/httpd/error_log
```

3. If you get permission errors, make sure your user has access to the document root directories:
```bash
sudo chown -R $(whoami) /opt/homebrew/var/www/
```

4. To verify Apache is listening on port 80:
```bash
sudo lsof -i :80
```