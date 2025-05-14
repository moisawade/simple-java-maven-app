pipeline {
    agent {
        label 'builder'
    }

    environment {
        sonarqube_token = credentials('sonar-secret-id')
    }
    
    tools {
        maven 'Maven'
    //    jdk 'JDK11'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }
        
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn sonar:sonar -Dsonar.projectKey=simple-java-maven-app -Dsonar.projectName="simple-java-maven-app"'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                    sh 'docker build -t mycompany/simple-java-maven-app:latest .'
            }
        }


        // stage('Build Docker Image') {
        //     steps {
        //         script {
        //             docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
        //         }
        //     }
        // }
        
        // The good things at the end
        // stage('Quality Gate') {
        //     steps {
        //         timeout(time: 1, unit: 'HOURS') {
        //             waitForQualityGate abortPipeline: true
        //         }
        //     }
        // }

    }
}