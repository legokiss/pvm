from fabric.api import run, task
import os

env_root_dir = os.path.expanduser("~/.pvm")
if not os.path.exists(env_root_dir):
	os.makedirs(env_root_dir)

@task
def list():
	envs = [env for env in os.listdir(env_root_dir)]
	if len(envs) == 0:
		print "no virtualenv installed"
	else:
		print "Installed virtualenv:"
		for env_name in envs:
			print env_name

@task
def install(env_name = None):
	if env_name:
		env_path = env_path_from_name(env_name)
		if os.path.exists(env_path):
			print "virtualenv",env_name,"has installed. \n'pvm use",env_name,"' to use it"
		else:
			os.system("virtualenv "+env_path)			
			print "install virtualenv",env_name,"success"
		pass
	else:
		print "missing virtualenv name, e.g.\npvm install:env_name"

@task
def use(env_name = None):
	if env_name:
		env_path = env_path_from_name(env_name)
		if os.path.exists(env_path):
			activate_path = os.path.join(env_path,"bin/activate")
			with open("run_env.sh","w") as bash_file:
				command_line = "source "+activate_path
				print "run command:\n",command_line,"\nin your shell.\nI'don't know how to run it in Python, if you know, please tell me. :)"
		else:
			print "not found virtualenv:",env_name,",'pvm list' to list all installed envs"
	else:
		print "missing virtualenv name, use 'pvm list' to list all installed envs"

def env_path_from_name(env_name):
	env_path = None
	if env_name:
		env_path = os.path.join(env_root_dir,env_name)
	return env_path

