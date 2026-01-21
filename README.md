# Docker Image – Node.js + OCI CLI + Git

Este repositório existe para **padronizar e estabilizar ambientes de deploy**, evitando problemas comuns de pipelines como dependências ausentes, versões inconsistentes e erros de execução (`ENOGIT`, `command not found`, `exit code 127`, etc.).

## 🎯 Objetivo

Fornecer uma imagem Docker pronta para uso em pipelines (ex: Bitbucket Pipelines, GitHub Actions), contendo todas as dependências necessárias para:

- **Build de aplicações frontend** (Vite, Webpack, React, Single-SPA).
- **Execução de monorepos com Lerna 8** (incluindo detecção de mudanças via Git).
- **Deploy de artefatos** para OCI Object Storage.
- **Execução de scripts shell** (`.sh`) de deploy.

## 📦 O que esta imagem inclui

- **Node.js 22.x** (Runtime principal)
- **Git** (Obrigatório para filtros do Lerna `--since` / `--filter`)
- **Yarn** (Gerenciador de pacotes)
- **Lerna** (Gerenciamento de monorepo)
- **OCI CLI** (Interface de linha de comando da Oracle Cloud)
- **bash / curl / jq** (Utilitários para scripts de automação)
- **python3 + pip** (Base para instalação do OCI CLI)

Tudo já configurado e validado no build da imagem.

## 🐳 Imagem Docker

A imagem é publicada no **GitHub Container Registry (GHCR)**:

```sh
ghcr.io/joseeduardomartins/docker-image-node-oci
```

Exemplo de tag:

```sh
ghcr.io/joseeduardomartins/docker-image-node-oci:1.0.0
```

## 🚀 Uso em CI/CD
### Bitbucket Pipelines

Exemplo de step para deploy:

```
- step:
    name: Deploy TEST
    image: ghcr.io/joseeduardomartins/docker-image-node-oci:1.0.0
    script:
      # Essencial para permitir que o Git funcione dentro do container do Bitbucket
      - git config --global --add safe.directory /opt/atlassian/pipelines/agent/build
      
      # Garante que a tag/branch de comparação exista no histórico local
      - git fetch origin test-oci:test-oci
      
      # Execução do deploy apenas nos pacotes alterados desde a tag
      - yarn lerna run deploy --concurrency 1 --since test-oci
```

## 🧪 Testar a imagem localmente

### Build local

```bash
docker build -t docker-image-node-oci .
```

### Executar container interativo

```bash
docker run -it --rm docker-image-node-oci sh
```

### Validar ferramentas

Dentro do container:

```bash
node -v
yarn -v
lerna --version
oci --version
jq --version
```

## 📌 Casos de uso comuns

- Monorepos com Lerna 8: Deploy inteligente apenas de pacotes modificados.
- Microfrontends com Single-SPA: Build e atualização automatizada de import-map.json no OCI.
- Storybook: Upload de documentação estática para o Object Storage com suporte a Content-Type.
- Pipelines Complexos: Automação via scripts .sh que dependem de manipulação de JSON (jq) e chamadas de API (curl).
