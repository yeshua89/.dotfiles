-- IMPORTANTE: Define tu API key en una variable de entorno:
-- export GOOGLE_API_KEY="tu-api-key-aqui"
-- O añádelo a tu .bashrc/.zshrc

return {
  google_api_key = vim.env.GOOGLE_API_KEY or "",
}
