# Database

## MySQL
- brew install mysql
- To run when start in backgroun and other 
    - brew services start mysql
    - brew services stop mysql
    - brew services remove mysql
- To manual start, stop and status
    - mysql.server start
    - mysql.server stop
- brew install phpmyadmin
- then create symlink, So we can access phpmyadmin through phpmyadmin.test when valet is running: 
    - ln -s /opt/homebrew/opt/phpmyadmin/share/phpmyadmin  ~/Sites/phpmyadmin

## PostgresSQL
- brew install postgresql
- brew services start postgresql
- brew services list
- brew install --cask tableplus :: For GUI Table view

## Import .sql into db
- mysql -u your_username -p db_name < /path/to/your/file.mysql
- mysql -u root -p database_name < mysql.sql