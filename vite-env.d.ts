/// <reference types="vite/client" />

interface ImportMetaEnv {
  readonly API_KEY: string
  readonly VITE_ADMIN_PASSWORD: string
  // adicione aqui outras variáveis que você usa
}

interface ImportMeta {
  readonly env: ImportMetaEnv
}
