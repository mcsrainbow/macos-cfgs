#!/bin/bash

# Error handling in bash scripts
set -euo pipefail

kube_cmd=/opt/homebrew/bin/kubectl
kube_dir=~/.kube

cd $kube_dir/config.d
kubeconfig_str=$(ls -1rt *.config | xargs | sed s/\ /:/g)

echo "INFO: Backing up the config to directory ${kube_dir}/backups..."
cp -p ${kube_dir}/config ${kube_dir}/backups/config.$(date +%Y%m%d%H%M)

echo "INFO: Regenerating the ${kube_dir}/config..."
KUBECONFIG=${kubeconfig_str} ${kube_cmd} config view --merge --flatten > ${kube_dir}/config

echo "INFO: Done"
