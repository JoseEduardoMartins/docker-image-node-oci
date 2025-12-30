# Node 22.14.0
FROM node:22.14.0-alpine

# Dependências do sistema
RUN apk add --no-cache \
  bash \
  curl \
  jq \
  python3 \
  py3-pip

# Criar virtualenv para OCI CLI
RUN python3 -m venv /opt/oci-cli

# Instalar OCI CLI dentro do venv
RUN /opt/oci-cli/bin/pip install --no-cache-dir oci-cli

# Expor binários no PATH
ENV PATH="/opt/oci-cli/bin:/root/.yarn/bin:/root/.config/yarn/global/node_modules/.bin:${PATH}"

# Lerna global
RUN yarn global add lerna

# Validação obrigatória
RUN node -v \
 && yarn -v \
 && lerna --version \
 && oci --version \
 && jq --version

WORKDIR /app
