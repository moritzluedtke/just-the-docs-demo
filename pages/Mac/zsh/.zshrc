#### Alias ####
alias ls="gls -ha --color --group-directories-first"
alias ll="gls -lah --color --group-directories-first"
alias wll="watch -n 1 gls -lah --group-directories-first"

## Quickly jump to project folders
alias work="cd ~/workspace"
alias service="cd ~/workspace/project/service"

alias ports="lsof -Pn -i4 -i6"

alias k="kubectl"
alias gr="./gradlew"
alias py3="python3.9"
alias mvn8="JAVA_HOME=`/usr/libexec/java_home -v 1.8` mvn"

alias zrc="vim ~/.zshrc"
alias szrc="source ~/.zshrc"

alias awslogin='saml2aws login --session-duration 36000 --skip-prompt'
alias awsownerprofile='AWS_PROFILE=ROLE_TO_CHOOSE'

## Git ##

# Git Status - A shortcut for "git status".
alias gits="git status"

# Git Log - Shows the git log for the current branch in a pretty format.
alias gitl="git log --pretty=format:'%C(178)%h%Creset %<(12)%C(26)%cr%Creset %<(18)%C(93)%cN%Creset %C(bold 124)%d%Creset | %s'"

# Git Orphaned Branch Delete - Deletes local branches which are no longer present in the remote repository.
alias gitobd="git checkout main && git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D"

# Git revert last local commit and get the changes back
alias gitr="git reset HEAD~1"

# Stash, Pull, Pop
alias spp="git stash; git pull; git stash pop"

# Merge changes from main into current feature branch
function gitmm() {
	current_branch=`git branch --show-current`
	printf "\n==> Checking out main branch \n\n"
	git checkout main
	printf "\n==> Updating main branch \n\n"
	git pull
	printf "\n==> Checking out $current_branch \n\n"
	git checkout $current_branch
	printf "\n==> Merging main branch into $current_branch \n\n"
	git merge main
}

function migrateToMainBranch() {
	git checkout master
	git branch -m master main
	git fetch
	git branch --unset-upstream
	git branch -u origin/main
}

## Other ##

# Run OWASP Check in maven project
function owasp() {
	# mvn clean package dependency-check:check -P owasp;
	./gradlew dependencyCheckAnalyze;
}

# Brew Upgrade Compact
function buc () {
	echo "---- Updating Homebrew itself ----";
	brew update;
	echo "---- Upgrading brew installs ----";
	brew upgrade | grep Upgrading;
	echo "---- Doing greedy updates ----";
    brew upgrade --greedy | grep Upgrading;
}

#### Exports ####
export LANG="en_US.UTF-8" # for Git primarily
export PS1="%d %% "

#export GRAALVM_HOME=/Library/Java/JavaVirtualMachines/graalvm-ce-java12-20.2.0/Contents/Home
#export JAVA_HOME=$GRAALVM_HOME
export JAVA_HOME=`/usr/libexec/java_home`
export GOPATH=~/go
export PYPATH=/Library/Frameworks/Python.framework/Versions/3.9
export PATH=$GOPATH/bin:$PYPATH/bin:$PATH
export KUBECONFIG=$KUBECONFIG:~/.kube/config:~/.kube/lab-config:~/.kube/kubeconfig-eks:~/.kube/poc-kubeconfig-eks:~/.kube/smile-dev-eks
export PATH="/usr/local/opt/node@16/bin:$PATH" # Only needed, because Node was installed with brew and is not using the latest version (17.x)

export GREP_OPTIONS='--color=always'
export GREP_COLOR='1;31'

# export HTTP_PROXY=''
# export HTTPS_PROXY=''

#### Functions ###
function cdr() {
  cd $(printf "%0.s../" $(seq 1 $1 ));
  
  if [ -n "$2" ]; then
    cd $2
  fi
}

function hub2lab() {
	if [ -n "$1"  ]; then
		NEWTAG="bp-lab-dev3.otto.boreus.de/$1"

		docker pull $1
		docker tag $1 $NEWTAG
		docker push $NEWTAG
	else
		echo "No image name provided."
	fi
}

function helpme() {
  cat << EOF
== General ==
wll   = watch ll
cdr   = cd in reverse (go up)
mvn8  = mvn command using java 1.8
ports = list all ports (IPv4 & IPv6)
zrc   = open .zshrc file
szrc  = reload .zshrc file

== Git ==
gits   = git status
gitl   = git log
gitobd = git orphaned branch delete
gitr   = git revert last commit
gitmm  = git merge main (into current branch)
spp    = git stash/pull/pop

== Docker ==
dr $  = docker restart MY_CONTAINER
de $  = open bash inside container MY_CONTAINER
dl $  = docker logs MY_CONTAINER
dip $ = get IP address of MY_CONTAINER
dps   = docker ps
dpsa  = docker ps -a
wdps  = watch docker ps
dsc   = docker stats compact

== Kubernetes ==
kdp = Kubernetes Delete Pod (Deletes unused/evicted pods)
EOF
}

# Convert Fredhopper CSV Files to Dollar seperated files
function convertFredhopperCSVs() {
	echo "Converting categories.csv ..."
	sed -i.bak $'s/\t\t/$$$$$$$$/' categories.csv
	sed -i.bak $'s/\t\t/$$$$$$$$/' categories.csv
	sed -i.bak $'s/\t\t/$$$$$$$$/' categories.csv
	sed -i.bak $'s/\t\t/$$$$$$$$/' categories.csv

	echo "Converting custom_attributes_meta.csv ..."
	sed -i.bak $'s/\t\t/$$$$$$$$/' custom_attributes_meta.csv
	sed -i.bak $'s/\t\t/$$$$$$$$/' custom_attributes_meta.csv
	sed -i.bak $'s/\t\t/$$$$$$$$/' custom_attributes_meta.csv
	sed -i.bak $'s/\t\t/$$$$$$$$/' custom_attributes_meta.csv

	echo "Converting custom_attributes_values.csv ..."
	sed -i.bak $'s/\t\t/$$$$$$$$/' custom_attributes_values.csv
	sed -i.bak $'s/\t\t/$$$$$$$$/' custom_attributes_values.csv
	sed -i.bak $'s/\t\t/$$$$$$$$/' custom_attributes_values.csv
	sed -i.bak $'s/\t\t/$$$$$$$$/' custom_attributes_values.csv
	sed -i.bak $'s/\t\t/$$$$$$$$/' custom_attributes_values.csv

	echo "Converting custom_variants_attributes.csv ..."
	sed -i.bak $'s/\t\t/$$$$$$$$/' custom_variant_attributes.csv
	sed -i.bak $'s/\t\t/$$$$$$$$/' custom_variant_attributes.csv
	sed -i.bak $'s/\t\t/$$$$$$$$/' custom_variant_attributes.csv
	sed -i.bak $'s/\t\t/$$$$$$$$/' custom_variant_attributes.csv
	sed -i.bak $'s/\t\t/$$$$$$$$/' custom_variant_attributes.csv

	echo "Converting products.csv ..."
	sed -i.bak $'s/\t\t/$$$$$$$$/' products.csv
	sed -i.bak $'s/\t\t/$$$$$$$$/' products.csv
	sed -i.bak $'s/\t\t/$$$$$$$$/' products.csv
	
	echo "Converting products.csv ..."
	sed -i.bak $'s/\t\t/$$$$$$$$/' variants.csv
	sed -i.bak $'s/\t\t/$$$$$$$$/' variants.csv
	sed -i.bak $'s/\t\t/$$$$$$$$/' variants.csv	
}

#### Docker ####
alias dps="docker ps"
alias dpsa="docker ps -a"
alias wdps="watch -n 1 docker ps"

alias dsc="docker stats --format 'table {{.Container}}\t{{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.MemPerc}}'"

function dr() {
  docker restart "$@";
}

function de() {
  docker exec -it $1 bash;
}

function dl() {
  docker logs -f $1;
}

function dip() {
  docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $1;
}

#### Kubernetes

# Kubernetes Delete Pod - Deletes unused/evicted pods.
function kdp() {
  kubectl get pods --all-namespaces | grep Evicted | awk '{print $2 " --namespace=" $1}' | xargs kubectl delete pod;
}

#### Zsh

## Explanation ##
# %B|%b start/stop bold
# %F|%f start/stop color
# %4~ show last 4 folders and shorten user directory to ~
# %# show # if sudo rights are active
PROMPT='%B%F{4}%4~%f%b %# '

autoload -Uz compinit  && compinit

## Code completion
# case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# Prevent empty line after each command

# Kubernetes
source <(kubectl completion zsh)

# Git integration
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{202}(%b) in %r%f'
zstyle ':vcs_info:*' enable git
