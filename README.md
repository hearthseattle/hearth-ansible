# Hearth Configuration Management

## Development and Local Provisioning

### Requirements:
- Python >=2.7.9, <3.x
- Ansible == 2.3.x.x
- [Vagrant](https://vagrantup.com) >=1.9.5, <2.0.0
- [Virtualbox](https://www.virtualbox.org/wiki/Downloads) >=5.0, <=5.1

- Copy `vagrant_settings.example.yml` to `vagrant_settings.yml` in this 
  directory. Change the path in `vagrant_settings.yml` for `hearth_dir` from 
  `~/Apps/hearth` to where ever the Django app is located on your local 
  machine. This repository and `hearth` work together to build the complete 
  application in the server.

### A Note About OSX and System Python
If you're running OSX, you have Python 2.7 installed by default. For the 
purposes of development, you don't want to make changes to this installation. 
It is recommended that you instead install the latest Python 2.7 on your 
system and place it at the front of your PATH. There are many resources online 
that walk through the process.

### Vagrant
Vagrant is a tool for building and managing virtual machine environments in a 
single workflow.

Vagrant will start a virtual machine using Virtualbox, and run Ansible 
provisioning on it. This enables us to create an environment that closely 
parallels our live environment, reducing inconsistencies and bugs. 
Additionally, Vagrant cuts setup time drastically and makes onboarding 
extremely simple and straight forward.

Once the above requirements are installed, you can simple run `vagrant up` 
to start the provisioning process. Once the machine is ready and booted, 
you can access the machine directly via `vagrant ssh`. A small cheatsheet 
is located at the end of this section with a number of helpful commands. 
All services should be running as soon as the box finishes provisioning. 
You can access the website by visiting localhost:8001 in your browser.

### Helpful Vagrant Commands (executed from top level of this repo)
- `vagrant up` - Start virtual machine; provision if not already done
- `vagrant ssh` - Ssh into machine for console access
- `vagrant reload` - Reload contents of Vagrantfile
- `vagrant halt` - Shutdown virtual machine
- `vagrant destroy` - Destroy virtual machine completely (run `vagrant up` to 
  bring it back up later)
- `vagrant status` - See if the machine is currently not created, shutdown, or 
running

### Helpful Commands within the Vagrant box
_Note: due to user permissions and environment variables, we use a shell 
script (`/var/www/hearth/manage.sh`) to wrap the `manage.py` command. Trying 
to invoke the `manage.py` executable directly will fail._

- `sudo -u hearthadmin <command>` - Run a command as the hearthadmin user
- `sudo -u hearthadmin /var/www/hearth/manage.sh <command>` - 
  Run a Django management command where `<command>` is the command you want to 
  run (ie `migrate`, `collectstatic`, etc)
- `sudo service hearth restart` - Restart Gunicorn process (reload Django app)
- `sudo service nginx restart` - Restart the Nginx webserver
- `sudo tail -f /var/log/upstart/hearth.log` - Follow application logs for 
  debugging

Because the above commands are lengthy and hard to remember, there are a few 
aliases that have been added to the box:
- `runserver` - Starts the Django runserver on port 8080 (to bypass Gunicorn 
  and Nginx)
- `manage <command>` - Run a Django management command where `<command>` is 
  the command you want to run
- `reload` - Reload the Django app (run anytime there are updates to Python
  or Django templates)
- `logs` - "Follow" the application log with tail (Ctrl+c to stop following)

### Important paths within Vagrant box
- `/var/www/hearth/` - Home directory for the application user (you'll find the 
  python code here)
- `/var/log/` - You'll find logs for _all_ processes in this directory
