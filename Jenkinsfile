pipeline {
    agent any

    environment {
        IMAGE_NAME = "syedowais247/todoapp"
    }

    stages {
        stage('Clone') {
            steps {
                git branch: 'main', url: 'https://github.com/syedowais247/your-repo-name.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${IMAGE_NAME}")
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub-creds', url: '']) {
                    script {
                        dockerImage.push("latest")
                    }
                }
            }
        }

        stage('Clean Up') {
            steps {
                sh "docker rmi ${IMAGE_NAME}"
            }
        }
    }
}
