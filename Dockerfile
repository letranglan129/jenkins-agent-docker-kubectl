FROM jenkins/inbound-agent:alpine

USER root

ENV KUBECTLVERSION=1.28.3

RUN curl -fsSL https://dl.k8s.io/release/v$KUBECTLVERSION/bin/linux/amd64/kubectl > /usr/local/bin/kubectl && chmod +x /usr/local/bin/kubectl

USER jenkins