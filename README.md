# acenoster.zsh-theme

A multipurpose ZSH theme with a very detailed git and mercurial prompt.

# Compatibility

**NOTE:** In all likelihood, you will need to install a [Powerline-patched font](https://github.com/Lokaltog/powerline-fonts) for this theme to render correctly.

To test if your terminal and font support it, check that all the necessary characters are supported by copying the following command to your terminal: `echo "\ue0a0 \u263f \u293b \u27a6 \u2213 \u00b1 \u271a \u25b2 \u25bc \u2714 \u25cb \u2699 \u2717"`. The result should look like this:

![Character Example](https://raw.githubusercontent.com/HiDe-Techno-Tips/Acenoster-ZSH-Theme/main/characters.png)

## What does it show?

- Username@Hostname (Username turns red if root)
- '⤻' AWS profile name if any (profile name in red if contains "-prod" or "production")
- Full working directory
- Version control status
  - Git branch '', detached head '➦' or Mercurial branch '☿'
  - Name of current git branch or revision@name of mercurial branch or bzr@revision of bazaar if any
  - '∓' if any untracked files present in git, mercurial or bazaar
  - '±' if any tracked files modified in git, mercurial or bazaar
  - '✚' if any modifications staged in git
  - '✔' if the working tree is clean in git, mercurial or bazaar
  - '▲' number of commits ahead of origin in git or mercurial if any
  - '▼' number of commits behind origin in git if any
- Virtual environment name if any
- '⚙:' No of background tasks if any
- '✗:' Previous command's exit code if non zero or '○' if zero.

![Screenshot](https://raw.githubusercontent.com/HiDe-Techno-Tips/Acenoster-ZSH-Theme/main/screenshot.png)
