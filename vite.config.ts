import { defineConfig, loadEnv } from "vite"
import react from "@vitejs/plugin-react"

// https://vitejs.dev/config/
export default defineConfig(({ mode }) => {
  const env = loadEnv(mode, process.cwd(), "")

  return {
    plugins: [react()],
    define: {
      "process.env.API_KEY": JSON.stringify(env.API_KEY || ""),
      "import.meta.env.VITE_ADMIN_PASSWORD": JSON.stringify(env.ADMIN_PASSWORD || "default-password"),
    },
    server: {
      proxy: {
        "/files": {
          target: "http://localhost:3001",
          changeOrigin: true,
          secure: false,
        },
        "/messages": {
          target: "http://localhost:3001",
          changeOrigin: true,
          secure: false,
        },
        "/api": {
          target: "http://localhost:3001",
          changeOrigin: true,
          secure: false,
        },
      },
    },
  }
})
