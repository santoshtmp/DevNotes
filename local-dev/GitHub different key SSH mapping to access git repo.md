# GitHub different key SSH mapping to access git repo

---
tags:
  - devops
  - linux
  - git
  - note
  - personal
---

**1. Generate Separate SSH Keys:**

Create two SSH key pairs, one for each repository (or rather, for each GitHub account/organization). Use the following commands, ensuring you provide different filenames and optionally different passphrases:


```bash
ssh-keygen -t ed25519 -C "backend@example.com" -f ~/.ssh/backend_ed25519
ssh-keygen -t ed25519 -C "frontend@example.com" -f ~/.ssh/frontend_ed25519
```

- `-t ed25519`: Specifies the Ed25519 algorithm (recommended for security).
- `-C "comment"`: Adds a comment to the key (usually an email address). This helps you identify the key.
- `-f ~/.ssh/filename`: Specifies the filename for the key. _This is crucial; use different filenames._

**2. Add Public Keys to GitHub:**

For each key you generated, you need to add the _public key_ to the appropriate GitHub account settings.

- **Copy the public key:**
    ```bash
    cat ~/.ssh/backend_ed25519.pub  # Copy this output
    cat ~/.ssh/frontend_ed25519.pub # Copy this output
    ```

- **Go to GitHub:** In your GitHub account settings, navigate to "SSH and GPG keys."
- **Add a new SSH key:** Paste the copied public key into the "Key" field and give it a descriptive title (e.g., "backend-machine," "frontend-machine"). Repeat this for the second public key.

**3. Configure SSH Config File (`~/.ssh/config`):**

This is the most important step. You need to tell SSH which key to use for which host. Create or edit your `~/.ssh/config` file:

```bash
# Backend Repository
Host github.com-backend
    HostName github.com
    User git
    IdentityFile ~/.ssh/backend_ed25519

# Frontend Repository
Host github.com-frontend
    HostName github.com
    User git
    IdentityFile ~/.ssh/frontend_ed25519
```

- **`Host github.com-backend` and `Host github.com-frontend`:** These are _aliases_. You'll use these in your Git remote URLs.
- **`HostName github.com`:** The actual hostname of GitHub.
- **`User git`:** The Git user for GitHub.
- **`IdentityFile ~/.ssh/backend_ed25519` and `IdentityFile ~/.ssh/frontend_ed25519`:** The paths to your _private_ key files.

**4. Add Git Remotes:**

Now, when you add your Git remotes, use the aliases you defined in your `~/.ssh/config` file:

Bash

```bash
# In /home/foo/application/backend
git remote add origin git@github.com-backend:username/backend-repo.git

# In /home/foo/application/frontend
git remote add origin git@github.com-frontend:anotheruser/frontend-repo.git
```

Notice the use of `github.com-backend` and `github.com-frontend` after `git@`. This tells SSH to use the corresponding settings from your `~/.ssh/config` file.
