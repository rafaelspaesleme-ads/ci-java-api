#imagem do pacote de execucao da apicacao em questao
FROM openjdk:${VERSION_JDK}
FROM maven:${VERSION_MVN}

#update packages

ENV DB_NAME ${DATABASE_DB}
ENV DB_USER ${DATABASE_USER}
ENV DB_PASSWORD ${DATABASE_PASSWORD}
ENV DB_HOST ${DATABASE_HOST}
ENV DB_PORT ${DATABASE_PORT}

#Criando diretorio da aplicação
RUN mkdir /app

#Criando diretorio para o microservice (aplicacao)
WORKDIR /app

#Copie o .jar no diretório de trabalho
COPY target/${NAME_APP}.jar /app

#Configuracao de porta
EXPOSE ${PORT_APP}

#Copiando entrypoint para pasta raiz
COPY devops/scripts/app/entrypoint.sh /app

#Executando permissão de execução
RUN chmod +x /app/entrypoint.sh

#Executando entrypoint
RUN bash -c '/app/entrypoint.sh'

#Comando que será executado assim que executarmos o contêiner
CMD ["java","-jar","${NAME_APP}.jar"]
