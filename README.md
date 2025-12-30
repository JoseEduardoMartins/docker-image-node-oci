# Docker Image – Node.js + OCI CLI

Imagem Docker customizada para **pipelines de CI/CD**, focada em projetos JavaScript/TypeScript que utilizam **Node.js**, **Yarn**, **Lerna** e **Oracle Cloud Infrastructure (OCI CLI)**.

Este repositório existe para **padronizar e estabilizar ambientes de deploy**, evitando problemas comuns de pipelines como dependências ausentes, versões inconsistentes e erros de execução (`command not found`, `exit code 127`, etc.).

## 🎯 Objetivo

Fornecer uma imagem Docker pronta para uso em pipelines (ex: Bitbucket Pipelines, GitHub Actions), contendo todas as dependências necessárias para:

Build de aplicações frontend (Vite, Webpack, React, Single-SPA)

Execução de monorepos com Lerna

Deploy de artefatos para OCI Object Storage

Execução de scripts shell (`.sh`) de deploy

## 📦 O que esta imagem inclui

- **Node.js**
- **Yarn**
- **Lerna**
- **OCI CLI**
- **bash**
- **curl**
- **jq**
- **python3 + pip**

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
      - yarn lerna exec --since main -- yarn deploy
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

- Monorepos com Lerna
- Microfrontends com Single-SPA
- Build com Vite / Webpack
- Deploy de arquivos estáticos no OCI Object Storage
- Pipelines com scripts .sh