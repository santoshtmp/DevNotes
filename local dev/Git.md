## General
```
git status
git branch <branch_name>
git checkout <branch_name>
git checkout -b <branch_name>
git fetch --all
git branch -list
git pull origin <main-branch>
git add .
git commit -m "msg"
git push origin <main-branch>
git pull origin <main-branch>
git log
git reset hard HEAD 5b283db4e49857896197eb3e4b2556813340bbe1
git reset --hard
git rebase main
    check and solve conflict if present
git push origin <main-branch> -f 
    force push if alrady pushed and need to push the resolved error.

```

## Repository Setup
- git init                     # Initialize new repo
- git clone <url>              # Clone existing repo

## Branching
- git branch                   # List local branches
- git branch -r                # List remote branches
- git branch -a                # List all branches
- git branch <branch_name>     # Create branch
- git checkout -b <branch>     # Create and switch to a new branch
- git checkout <branch>        # Switch branches
- git merge <branch>           # Merge another branch into current one
- git branch -d <branch>       # Delete a branch

## Staging & Committing
- git status                   # Show changes
- git add <file>               # Stage a file
- git add .                    # Stage all changes
- git commit -m "Message"      # Commit with message
- git reset <file>             # Unstage a file

## Sync with Remote
- git fetch --all                     # Fetch all branches from all remotes
- git fetch <remote>                  # Fetch from remote
- git fetch <remote> <branch>         # Fetch specific branch
- git pull <remote> <branch>          # Pull from remote and merge
- git push <remote> <branch>          # Push to remote


## Remote Management
```
git remote                                  # List remotes
git remote -v                               # Show remote URLs
git remote show <origin>                    # Show details list of a specific remote
git remote rename <old> <new>               # Rename a remote (e.g., origin → new_origin_remote)
git remote add myorigin <remote_repo_url>   # Add a new remote named 'myorigin'
```

## Log & History
```
git log                      # Show commit history
git log --oneline            # Condensed log
git diff                     # Show unstaged changes
git diff --staged            # Show staged changes
```

## Undo Changes
```
git checkout -- <file>       # Discard changes
git reset --soft HEAD~1      # Undo last commit, keep changes staged
git reset --hard HEAD~1      # Undo last commit, delete changes
```

## Cleanup
- git clean -fd                # Delete untracked files and dirs
- git gc                       # Garbage collection

# upload local file to remote location
### local: Archive.zip to remote: districtfray@65.181.111.4:public_html/wp-content/uploads/2023/
scp Archive.zip districtfray@65.181.111.4:public_html/wp-content/uploads/2023/ 


chmod -R 755 uploads

