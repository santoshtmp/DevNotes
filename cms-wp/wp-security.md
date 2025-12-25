# WordPress Security

A practical, checklist-driven guide to securing WordPress websites during development, deployment, and maintenance.

---

## Foundation (Must-Do Basics)

- Always use the **latest stable WordPress version**
- Keep **themes and plugins updated**
- Remove unused themes and plugins
- Use **strong, unique passwords**
- Never use the default `admin` username
- Enable **HTTPS (SSL)** everywhere

---

## Hosting & Server Security

- Choose hosting with:
  - Server-level firewall
  - Malware scanning
  - Daily backups
- Use **PHP 8.1+** (supported version)
- Disable directory listing
- Use correct file permissions:
  - Directories: `755`
  - Files: `644`
- Protect sensitive files:
  - `wp-config.php`
  - `.env`
  - `.htaccess`



## WordPress Configuration
- Disable File Editing in Admin
    ```php
    define('DISALLOW_FILE_EDIT', true);
    ```

- Disable XML-RPC (if not required)
    ```php
    add_filter('xmlrpc_enabled', '__return_false');
    ```

- Hide WordPress Version
    ```php
    remove_action('wp_head', 'wp_generator');
    ```

-  Other configuration in wp-config.php 
    ```php
    define('AUTOMATIC_UPDATER_DISABLED', false);
    define('DISABLE_WP_CRON', true);
    ```


- Disable REST API for unauthenticated users if not needed: 
https://developer.wordpress.org/reference/hooks/rest_authentication_errors/

- Header Security in send_headers https://developer.wordpress.org/reference/hooks/send_headers/ 
    ```php
    header('X-FRAME-OPTIONS: SAMEORIGIN');
    header('Referrer-Policy: strict-origin-when-cross-origin');
    header('X-Content-Type-Options: nosniff');
    header('X-XSS-Protection: 1; mode=block');
    header("Content-Security-Policy: frame-ancestors 'self';");
    header('Strict-Transport-Security: max-age=31536000; includeSubDomains');
    header("Permissions-Policy: geolocation=(self), microphone=(), camera=(), payment=(), fullscreen=*");
    header("X-Permitted-Cross-Domain-Policies: none");
    ```

- Media Upload Security
  - Put this in your root .htaccess file
  ```apache
    # Disable PHP execution in uploads directory
    <Directory "/wp-content/uploads">
      php_flag engine off
    </Directory>
  ```

  - .htaccess inside uploads folder: wp-content/uploads/.htaccess
  ```apache
    # Disable PHP execution in uploads directory
    php_flag engine off
    <FilesMatch "\.php$">
      Deny from all
    </FilesMatch>
  ```
  
  - Works ONLY if: Server = Apache and mod_php enabled
  - In NGINX server; place in server congif 
  ```nginx
  location ~* /wp-content/uploads/.*\.php$ {
      deny all;
  }
  ```

- Enable rate limiting on login and API endpoints


## HTTP Security Headers
Recommended headers:
- Content-Security-Policy (CSP)
- X-Frame-Options
- X-Content-Type-Options
- Referrer-Policy
- Strict-Transport-Security (HSTS)

Example configuration in htaccess:

```apache
Header set X-Frame-Options "SAMEORIGIN"
Header set X-Content-Type-Options "nosniff"
Header set Referrer-Policy "strict-origin-when-cross-origin"
```

## Input Validation & Secure Coding
- Sanitize all user input
    - sanitize_text_field()
    - sanitize_email()
- Escape all output
    - esc_html()
    - esc_attr()
    - esc_url()
- Validate data server-side
- Use WordPress nonces for forms and AJAX. Use nonces to prevent CSRF
- Use prepared SQL statements
- Never trust user input

## CSRF, XSS & SQL Injection Protection
- Use nonces to prevent CSRF
- Escape output to prevent XSS
- Avoid raw SQL queries
- Enforce CSP to restrict script execution

## Authentication & Access Control
- Enable Two-Factor Authentication (2FA)
- Limit login attempts
- Enable CAPTCHA on:
    - Login
    - Registration
    - Password reset
    - Contact forms
- Restrict admin access by IP (if possible)
- Assign proper user roles (avoid giving admin access unnecessarily)

## Security Plugins (Choose One Core Plugin)
- Wordfence Security
- WP Cerber Security
- iThemes Security
- All In One WP Security & Firewall

Do not install multiple firewall/security plugins together. Recommended all-in-one security plugins

