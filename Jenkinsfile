pipeline {
    agent {
        label 'buildertwo'
    }

    environment {
        sonarqube_token = credentials('sonar-secrets-id')
        IMAGE_NAME = "medlamin13956814/exercise_with_deploy"
        IMAGE_TAG = "latest"
    }
    
    // tools {
    //     maven 'Maven'
    // //    jdk 'JDK11'
    // }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        // stage('Build') {
        //     steps {
        //         sh 'mvn clean package -DskipTests'
        //     }
        // }
        
        // stage('Test') {
        //     steps {
        //         sh 'mvn test'
        //     }
        // }
        
        // stage('SonarQube Analysis') {
        //     steps {
        //         withSonarQubeEnv('SonarQube') {
        //             sh 'mvn sonar:sonar -Dsonar.projectKey=simple-java-maven-app -Dsonar.projectName="simple-java-maven-app"'
        //         }
        //     }
        // }

        stage('Build Docker Image') {
            steps {
                    sh 'sudo docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
            }
        }

        //  Optional: Push Docker image to a registry
        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docker-image-id',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        echo "$DOCKER_PASS" | sudo docker login -u "$DOCKER_USER" --password-stdin
                        sudo docker push ${IMAGE_NAME}:${IMAGE_TAG}
                    '''
                }
            }
        }

        stage('Deploy Docker Image') {
            steps {
                    sh 'sudo docker run -d rm -f -p 9010:80 ${IMAGE_NAME}:${IMAGE_TAG}'
                    
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