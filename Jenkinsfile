pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Checkout the source code from Git
                git branch: 'main', url: 'https://github.com/Ravali08/java11-sonar.git'
            }
        }
        
        stage('Docker Build') {
            steps {
                // Build Docker image
                script {
                     sh "docker buildx build -t ravali218/test:1.0.${BUILD_NUMBER} ."
                }
            }
        }

        stage('Test with SonarQube') {
            steps {
                // Run tests and analyze with SonarQube
                withSonarQubeEnv('sonar') { 
                    sh "mvn clean verify sonar:sonar -Dsonar.projectKey=demo-sonar"
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                // Push Docker image to DockerHub
                script {
                    sh "docker push ravali218/test:1.0.${BUILD_NUMBER}"
                    }
                }
            }

        stage('Deploy to DockerHub') {
            steps {
                // Deploy Docker image from DockerHub
                script {
                    sh "docker rm -f my-app || true"
                    sh "docker run -itd --name my-app -p 9000:8080 ravali218/test:1.0.${BUILD_NUMBER}"
                    }
                }
            }
    }
}
