FROM nginx:1.27-alpine

RUN rm -rf /usr/share/nginx/html/*

# Copia seu conteúdo
COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]