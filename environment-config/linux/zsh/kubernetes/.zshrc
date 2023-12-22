# Kubernetes
alias k=kubectl
alias kA=kubectl --all-namespaces
alias k=kubecolor
alias kubectl=kubecolor
alias kA=kubecolor --all-namespaces

source <(kubectl completion zsh)
compdef __start_kubectl k
compdef __start_kubectl kA
compdef kubecolor=kubectl

k8s-ps()
{
   k get pods -o wide --all-namespaces
}