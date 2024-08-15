# Use uma imagem base do Nginx
FROM nginx:alpine

# Copie os arquivos do build para o diretório do Nginx
COPY build/web /usr/share/nginx/html

# Exponha a porta que o Nginx vai usar
EXPOSE 80

# Comando para iniciar o Nginx
CMD ["nginx", "-g", "daemon off;"]
