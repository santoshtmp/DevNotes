# SVN
1. svn checkout https://plugins.svn.wordpress.org/post-title-required/
2. svn status
3. svn add filename.php
4. svn delete oldfile.php
5. svn commit -m "Updated plugin functionality and readme."

## To Ignore Files in SVN 
- To sets the svn:ignore property on the current directory (.) — not globally.
```
svn propset svn:ignore "
.DS_Store
node_modules
.git
.gitignore
npm-debug.log
*.log
*.zip
.svnignore" .
```
```
svn propset svn:ignore ".svnignore" .
```
- To check ignore property
```
svn propget svn:ignore .
```



## Example
svn checkout https://plugins.svn.wordpress.org/post-title-required/
cd post-title-required/trunk
# Make changes
- svn add file.php
- svn commit -m "New update"
# When ready to release
- svn copy trunk tags/1.2
- svn commit -m "Tag 1.2 release"
