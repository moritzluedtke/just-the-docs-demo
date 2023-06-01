# Git

## Delete local branches which are deleted in origin

```shell
git remote prune origin
```

## GPG signing (Mac)

```shell
# https://www.jetbrains.com/help/idea/set-up-GPG-commit-signing.html#d79ba874
brew install pinentry-mac

# in zsh.rc
alias pinentry='pinentry-mac'
GPG_TTY=$(tty)
export GPG_TTY
```
