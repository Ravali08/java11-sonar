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
                sh "mvn clean verify sonar:sonar -Dsonar.projectKey=demo-sonar -Dsonar.host.url=http://3.108.194.10:9000 -Dsonar.login=sqp_adb5940747fd2dfcccdb77cc7b20b174dfa67af8 -X"
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
