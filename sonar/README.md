#Install Agent jenkins
mkdir -p /datas/jenkins

#Install Java
sudo apt update
sudo apt install -y openjdk-17-jdk



#Install maven tools: via Jenkins configuration


# create a docker compose
version: '3'

services:
  sonarqube:
    image: sonarqube:community
    container_name: sonarqube
    ports:
      - "9000:9000"
    environment:
      - SONAR_JDBC_URL=jdbc:postgresql://db:5432/sonar
      - SONAR_JDBC_USERNAME=sonar
      - SONAR_JDBC_PASSWORD=sonar
    depends_on:
      - db

  db:
    image: postgres:12
    container_name: sonarqube_db
    environment:
      - POSTGRES_USER=sonar
      - POSTGRES_PASSWORD=sonar
      - POSTGRES_DB=sonar
    volumes:
      - sonarqube_db_data:/var/lib/postgresql/data

volumes:
  sonarqube_db_data:


Explanation:

SonarQube will run on http://localhost:9000.

PostgreSQL is required for SonarQube (it doesn't work with embedded databases anymore).

Default database username/password: sonar/sonar.



#launch Sonar
docker-compose up -d

http://localhost:9000

Default credentials:

Username: admin

Password: admin
