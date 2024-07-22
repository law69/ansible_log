#!/bin/bash

file_name=$1

hosts=($(cat ${file_name} | sed -n '/PLAY RECAP/,$p' | grep -v "PLAY RECAP" | cut -d" " -f1))
list=$(cat ${file_name} | sed -n '/PLAY RECAP/,$p' | grep -v "PLAY RECAP" | cut -d" " -f1)

for h in ${hosts[@]}; do
  echo "### file $h ###"
  flag=0
  while read st; do
    if ! echo "${st}" | grep -wqf <(echo -e "${list}" | grep -v "^#"); then
      if [ ${flag} -eq 0 ]; then
        echo -e "${st}"
      else
        if [[ "${st}" = "}" ]]; then 
            flag=0
        fi
      fi
    else
      if echo "${st}" | grep -wq "$h"; then
        echo -e "${st}"
      else
        if echo "${st}" | grep -q "{$"; then
          flag=1; 
        fi
      fi
    fi
  done < <(cat ${file_name})
done
