#Install:
#add `source /path/to/pvm.sh` in .zshrc or .bashrc. and then "source .zshrc" for example.

pvm_dir=$HOME"/.pvm"

function usage() {
	echo "Usage: \npvm list\npvm install:env_name\npvm use:env_name"
}

function list() {
	help_text="no installed virtualenvs, to make one:\npvm install:env_name"
	if [ -d $pvm_dir ]; then
		installed_envs=$(ls $pvm_dir)
		if [ -z "$installed_envs" ]; then
			echo $help_text
		else
			for env in $installed_envs
			do
				echo $env
			done
			echo "\n\"pvm use:env_name\" to use one of the above envs,\n\"pvm install:env_name\" to make one"
		fi
	else
		echo $help_text
	fi
}

function install() {
	env_name=$1
	help_text="to make virtual env need a name.\"pvm install:env_name\""
	env_name_path=$pvm_dir"/"$env_name

	if [ -z $env_name ]; then
		echo $help_text
	else
		if [ -d $env_name_path ]; then
			echo "$env_name has existed, \"pvm use:$env_name\" to activate it"
		else
			virtualenv $env_name_path
			echo "\ninstall succeed,\"pvm use:$env_name\" to activate it"
		fi
	fi
}

function use() {
	env_name=$1	
	env_path=$pvm_dir"/"$env_name
	activate_path=$env_path"/bin/activate"

	if [ -z $env_name ]; then
		echo "missing evn name, \"pvm use:env_name\""
	else
		if [ -d $env_path ]; then
			source $activate_path
		else
			echo "$env_name not exist, \"pvm install:$env_name\" to make it"
		fi
	fi
}

function pvm() {
	if [ -z $1 ]; then
		usage
	else
		command=$(echo $1 | cut -f1 -d":")
		argument=$(echo $1 | cut -f2 -d":")
		case $command in
			"list") list;;
			"install") install $argument;;
			"use") use $argument;;
			*) usage;;
		esac
	fi
}

