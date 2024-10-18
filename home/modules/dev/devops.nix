{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      # Container & VM Tools
      act
      kind
      dive
      eksctl
      minikube
      packer
      docker-client
      docker-compose
      rclone

      # Kubernetes Tools
      kubectl
      kubectx
      kubernetes-helm
      krew
      stern
      cilium-cli
      hubble
      argocd
      lens
      istioctl
      velero
      cmctl

      # Cloud Providers & Infrastructure as Code
      opentofu
      terragrunt
      awscli2
      # azure-cli

      # Security & Scanning Tools
      cosign
      kyverno
      checkov
      datree
      hadolint
      vault
      kics
      snyk
      kubesec
      trivy
      tfsec
      terrascan
      trufflehog
      kubescape
      kube-linter
      kube-bench
      kube-hunter
      starboard
      clair
      falcoctl
      checkmate

      # Testing & Linting Tools
      k6
      tflint
      cobra-cli
    ];
  };
}
