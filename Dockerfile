# Stage 1: build
FROM node:20-alpine AS builder

WORKDIR /app

# Copiar apenas package.json e lock
COPY package.json package-lock.json ./

# Instalar dependências
RUN npm install --legacy-peer-deps

# Copiar todo o projeto
COPY . .

# Build do projeto (TypeScript + Vite)
RUN npm run build

# Stage 2: produção
FROM node:20-alpine

WORKDIR /app

# Copiar apenas arquivos necessários para rodar
COPY --from=builder /app/package.json ./
COPY --from=builder /app/package-lock.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/server.js ./server.js

# Rodar a aplicação
CMD ["node", "server.js"]


