orbstack_config="${HOME}/.kube/config.d/orbstack.config"

kubectl config view --minify --raw --context=orbstack > ${orbstack_config}
gsed -i /current-context/d ${orbstack_config}

echo "INFO: Generated ${orbstack_config}"
lsd -lh --size short --date "+%a %Y-%m-%d_%H:%M:%S" ${orbstack_config}
kubectl config view --minify --context=orbstack | bat --theme="Solarized (dark)" --style=plain --language=yaml
