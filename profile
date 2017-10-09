#!/bin/bash

alias logs="sudo tail -f -n 25 /var/log/upstart/hearth.log"
alias reload="sudo service hearth restart"
alias manage="sudo -u hearthadmin /var/www/hearth/manage.sh"
alias runserver="manage runserver 0.0.0.0:8080"
