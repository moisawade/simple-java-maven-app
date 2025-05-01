#Run as container

docker run -d -p 8081:8081 --name nexus sonatype/nexus3

#Get password
docker exec -it nexus cat /nexus-data/admin.password

