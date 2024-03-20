Implementacao glpi splab
usar docker file para gerar imagem
Criar um banco de dados por exemplo:
docker run -d \
    --name mariadb \
    --restart always \
    --network glpi-network \
    --ip 172.20.0.6 \
    -e MARIADB_ROOT_PASSWORD=pass \
    -e MARIADB_DATABASE=glpi \
    -e MARIADB_USER=user \ 
    -e MARIADB_PASSWORD=pass \
    -v /home/raid/glpi/mariadb:/var/lib/mysql \
    -p 3306:3306 \
    mariadb:latest

Usando rede propria somente para glpi e o banco de dados.
