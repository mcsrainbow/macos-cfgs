#!/bin/bash

# Error handling in bash scripts
set -euo pipefail

if [[ ! -f ${1} ]]; then
  echo "ERROR: No such file '${1}'"
  exit 1
fi

echo "INFO: Changed cluster and context names in ${1}"
context_name=$(echo ${1}|cut -d- -f1-3)
cluster_name=$(echo ${1}|cut -d. -f1)
gsed -i -e "
  /contexts:/,/kind:/{
    /name:/ s|:.*|: ${context_name}|g;
  }
  s|kubernetes|${cluster_name}|g;
  /current-context/d;
" ${1}

awk 'NR<=12 && !/certificate-authority-data/' ${1} | bat --theme="Solarized (dark)" --style=plain --language yaml
