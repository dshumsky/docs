##### Commands
- current branch `git rev-parse --abbrev-ref HEAD`
- change parent `git branch local-branch --set-upstream-to origin/development`
- clear credentials `git credential-cache exit`
- return back 
    ```
    git checkout <commit_id> <path_to_file>
    git reset --hard HEAD~1
    git reset --soft  "HEAD^"```
- compare `git config --global diff.tool meld`, `git difftool -g -d d4d2b16..2f1af0b`
- get parents `alias gitparents='git for-each-ref --format="%(refname:short)" refs/heads/* | while read b; do if r=$(git config --get branch.$b.remote); then m=$(git config --get branch.$b.merge); echo "$b -> $r/${m##*/}"; fi; done'`
- clean-up branches: 
    ```
    function grmb() {
      git fetch -p
      git branch -v | grep '\[gone\]' | cut -d ' ' -f 3 | xargs git branch -d
    }
    ```
#### Tags
- `git fetch --all --tags`  
- delete all local tags `git tag -d $(git tag -l)`
- delete remote tag `git push origin :tagA`
  
##### Move root to `/foo/bar`
```
git filter-branch --prune-empty --tree-filter '
if [ ! -e foo/bar ]; then
    mkdir -p foo/bar
    git ls-tree --name-only $GIT_COMMIT | xargs -I files mv files foo/bar
fi'
```

##### Mirror repo
```bash
git clone --bare https://github.com/exampleuser/old-repository.git
git push --mirror https://github.com/exampleuser/new-repository.git

```

##### Permanently remove files and folders
```bash
# file or folder
git filter-branch --tree-filter 'rm -rf vendor/gems' HEAD
# range between commits
git filter-branch --tree-filter 'rm -rf vendor/gems' 7b3072c..HEAD
#
git reflog expire --expire=now --all
git gc --prune=now
#
git push origin master --force
```

##### Move preserving history
- see https://rtyley.github.io/bfg-repo-cleaner/
- git way
```bash
#  Stage #1
git remote rm origin
git filter-branch --subdirectory-filter <directory> -- --all
git filter-branch --tree-filter '(ls -A; mkdir TheSubdir; echo TheSubdir) | xargs mv'
git reset --hard 
git reflog expire --expire=now --all
git gc --prune=now
git prune 
#
#  Stage #2
git remote add repo-A-branch <git repository A directory>
git rebase ...

```
##### Configuration	
```
[user]  
  name  = ...
  email = ...
[core]  
  quotepath = false
  editor = vim
  autocrlf = input
[color] 
  diff = auto  
  status = auto 
  branch = auto    
  interactive = auto    
  ui = auto
  grep = auto
[push]    
  default = simple
[branch]
  autosetuprebase = always
  autosetupmerge = always
[alias]    
  lg = log --graph --full-history --all --color --pretty=format:\"%x09%h%x09%C(auto)%d%C(reset)%x20%s%x20%x20--%x20%x20%an,%x20%ad\" --date=relative -30
[gerrit]     
  createchangeid = true
[credential]
  helper = cache --timeout=3600000
[diff]    
  tool = meld
```
##### Gerrit
- hooks `cp ~/.git/hooks/commit-msg ./.git/hooks/commit-msg`
