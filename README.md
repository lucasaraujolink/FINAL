# Gonçalinho - Chat Analista de Dados

Aplicação web para análise de dados de saúde e indicadores sociais de cidades brasileiras usando IA generativa (Google Gemini).

## Características

- Upload e análise de arquivos (PDF, Excel, Word, CSV)
- Chat com IA para perguntas sobre os dados
- Geração de gráficos interativos (Bar, Line, Pie, Area)
- Persistência de dados em banco de dados local
- Interface responsiva com Tailwind CSS

## Tecnologia

- **Frontend**: React + TypeScript + Vite
- **Backend**: Node.js + Express
- **IA**: Google Gemini API
- **Database**: JSON persistente em arquivo
- **UI**: Tailwind CSS + shadcn/ui

## Instalação

### Pré-requisitos

- Node.js 18+
- Google Gemini API Key

### Setup Local

1. Clone o repositório:
\`\`\`bash
git clone <seu-repo-url>
cd goncalinho
\`\`\`

2. Instale as dependências:
\`\`\`bash
npm install
\`\`\`

3. Configure as variáveis de ambiente:
\`\`\`bash
cp .env.example .env
\`\`\`

4. Edite `.env` com suas credenciais:
\`\`\`
API_KEY=sua_chave_gemini_aqui
ADMIN_PASSWORD=sua_senha_segura_aqui
\`\`\`

5. Execute em desenvolvimento (com hot reload):
\`\`\`bash
npm run dev:full
\`\`\`

Ou separadamente:
\`\`\`bash
npm run start:server  # Terminal 1 - Backend na porta 3001
npm run dev          # Terminal 2 - Frontend na porta 5173
\`\`\`

## Scripts

- `npm run dev` - Inicia frontend com Vite
- `npm run build` - Build para produção
- `npm start` - Inicia server Node.js
- `npm run dev:full` - Inicia frontend e backend simultaneamente
- `npm run preview` - Preview do build

## Deploy no EasyPanel (Hostinger)

### Preparação

1. Faça commit e push para GitHub:
\`\`\`bash
git add .
git commit -m "Preparado para deploy"
git push origin main
\`\`\`

2. No EasyPanel do Hostinger:
   - Aplicação: Node.js
   - Versão Node: 20+
   - Build Command: `npm run build`
   - Start Command: `npm start`
   - Port: `3001` ou deixe em branco para auto

3. Variáveis de Ambiente (no painel do EasyPanel):
   - `API_KEY` = sua chave Gemini
   - `ADMIN_PASSWORD` = senha segura para admin
   - `NODE_ENV` = production

### Banco de Dados em Produção

- Todos os dados são salvos em `/data/db.json`
- Este arquivo persiste entre deploys (verifice com o suporte do Hostinger)
- Backup recomendado: Configure backup automático de arquivos

## Estrutura de Diretórios

\`\`\`
goncalinho/
├── components/        # Componentes React
├── services/          # Serviços (DB, Gemini, parser)
├── data/              # Banco de dados (criado automaticamente)
├── dist/              # Build para produção
├── App.tsx            # Componente principal
├── index.tsx          # Entry point
├── server.js          # Backend Express
├── vite.config.ts     # Config Vite
├── Dockerfile         # Config Docker (opcional)
└── package.json       # Dependências
\`\`\`

## Variáveis de Ambiente

| Variável | Descrição | Padrão |
|----------|-----------|--------|
| `API_KEY` | Google Gemini API Key | - (obrigatório) |
| `ADMIN_PASSWORD` | Senha de administrador | default-password |
| `PORT` | Porta do servidor | 3001 |
| `NODE_ENV` | Ambiente (development/production) | development |
| `VITE_API_URL` | URL da API para frontend | http://localhost:3001 |

## Segurança

- Senha de admin em variável de ambiente (não hardcoded)
- Rate limiting em produção (100 req/min)
- CORS configurável
- Dados sensíveis não expostos ao navegador

## Troubleshooting

### Erro "API Key is missing"
- Certifique-se que `API_KEY` está definida no `.env`
- Em EasyPanel, verifique as variáveis de ambiente

### Dados não persistem
- Verifique permissões de escrita na pasta `/data`
- Em EasyPanel, confirm que `/data` é volume persistente

### Port já em uso
- Mude `PORT` em `.env` ou `PORT=3002 npm start`

## Licença

MIT

## Suporte

Para problemas ou sugestões, abra uma issue no GitHub.
\`\`\`

```plaintext file="DEPLOYMENT.md"
# Guia de Deploy - EasyPanel (Hostinger)

## Step-by-Step

### 1. Preparar Repositório GitHub

\`\`\`bash
# Crie um .gitignore adequado (já existe)
git add .
git commit -m "Preparado para deploy no EasyPanel"
git push origin main
\`\`\`

### 2. No Painel do Hostinger (EasyPanel)

1. **Acesse**: Seu domínio → Applications (ou similar)
2. **Crie nova aplicação**:
   - Nome: `goncalinho-api`
   - Tipo: Node.js
   - Versão Node: 20 LTS (recomendado)

3. **Conecte GitHub**:
   - Repository: seu-usuario/goncalinho
   - Branch: main
   - Auto-deploy: Sim (opcional)

4. **Build & Start Commands**:
   - Build: `npm run build`
   - Start: `npm start`

5. **Environment Variables** (muito importante):
   \`\`\`
   API_KEY=AIzaSy... (sua chave do Gemini)
   ADMIN_PASSWORD=SenhaForte123!
   NODE_ENV=production
   PORT=3001
   \`\`\`

6. **Deploy** → Aguarde completar

### 3. Configurar Domínio

- Aponte seu domínio para a aplicação no EasyPanel
- HTTPS é configurado automaticamente

### 4. Testar

- Acesse `seu-dominio.com`
- Faça login com a senha
- Upload um arquivo
- Converse com a IA

### 5. Backup de Dados

No EasyPanel:
- Configure backup automático se disponível
- Ou faça backup manual de `/data/db.json`

## Troubleshooting Produção

### Aplicação não inicia

- Check console logs no EasyPanel
- Verifique se `npm start` consegue ser executado
- Confirme que todas as dependencies estão instaladas

### Erros de API

- Confirme `API_KEY` está correta
- Verifique quota do Google Gemini

### Dados desaparecem

- Arquivo `/data/db.json` foi deletado?
- Verificar permissões de escrita

## Performance

- Limite de upload: 50MB
- Rate limit: 100 req/min
- Resposta IA: ~10-30 segundos

## Monitoramento

Configure alertas no EasyPanel para:
- Uso de CPU
- Uso de memória
- Tempo de resposta

Recomendado manter below 50% em ambos.
