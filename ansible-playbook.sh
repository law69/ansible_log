#!/bin/bash

path_log=test_log

arg=$@
date_start=`date +"%F_%H-%M"`

__err () {
  echo $1; exit 1
}

[ ! -d ${path_log} ] && __err "Error: path to log \"${path_log}\" does not exist!"

pl="ansible-playbook ${arg}"

eval "ansible-playbook ${arg}" | tee ansible-playbook_$(date_start).log



