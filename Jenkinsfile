pipeline {
    agent {
        label 'builder'
    }

    environment {
        IMAGE_NAME = "dockermoisa/challengewebapp"
        IMAGE_TAG = "latest"
    }
    
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        

        stage('Build Docker Image') {
            steps {
                    sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
            }
        }

        stage('Trivy Security Scan') {
            steps {
                sh '''
                docker run --rm \
                -v /var/run/docker.sock:/var/run/docker.sock \
                -v $PWD:/root/reports \
                aquasec/trivy image \
                --format template \
                --template "@/contrib/html.tpl" \
                -o /root/reports/trivy-report.html \
                ${IMAGE_NAME}:${IMAGE_TAG}
                '''
            }
        }

        stage('Publish Trivy Report') {
            steps {
                publishHTML(target: [
                allowMissing: true,
                alwaysLinkToLastBuild: false,
                keepAll: true,
                reportDir: '.',
                reportFiles: 'trivy-report.html',
                reportName: 'Trivy Security Report',
                alwaysLinkToLastBuild: true
                ])
            }
        }

        //  Optional: Push Docker image to a registry
        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds-id',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push ${IMAGE_NAME}:${IMAGE_TAG}
                    '''
                }
            }
        }

        stage('Deploy Docker Image') {
            steps {
                sh 'docker run -p 8888:8080 ${IMAGE_NAME}:${IMAGE_TAG} '
            }
        }

    }
}