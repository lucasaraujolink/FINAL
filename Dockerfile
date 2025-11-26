FROM node:20-alpine AS builder

WORKDIR /app

# Copy package files
COPY package.json ./

RUN npm install --legacy-peer-deps

# Copy source code
COPY . .

# Build React app with Vite
RUN npm run build

# Production stage
FROM node:20-alpine

WORKDIR /app

COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package.json ./

# Copy server and other necessary files
COPY server.js .
COPY tsconfig.json .
COPY services/ ./services/
COPY public/ ./public/

# Create data directory for db.json persistence
RUN mkdir -p /app/data

# Expose port
EXPOSE 3001

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD node -e "require('http').get('http://localhost:3001', (r) => {if (r.statusCode !== 200) throw new Error(r.statusCode)})"

# Start application
CMD ["npm", "start"]

