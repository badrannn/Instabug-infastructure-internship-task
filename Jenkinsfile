pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
        DOCKER_IMAGE_NAME = 'instabug/internship-task:latest'
    }

    stages {
        stage('Build') {
            steps {
                
                catchError(buildResult: 'FAILURE', stageResult: 'FAILURE', message: 'Build failed: An error occurred during the build.') {
                    node {
                        sh "docker build -t ${DOCKER_IMAGE_NAME} ."
                    }
                }
                
            }
        }

        stage('Login') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub', variable: 'DOCKERHUB_CREDENTIALS_PSW')]) {
                    node {
                        sh "echo ${DOCKERHUB_CREDENTIALS_PSW} | docker login -u ${DOCKERHUB_CREDENTIALS_USR} --password-stdin"
                    }
                }
            }
        }

        stage('Push') {
            steps {
                catchError(buildResult: 'FAILURE', stageResult: 'FAILURE', message: 'Push failed: An error occurred during the push.') {
                    node{
                        sh "docker push ${DOCKER_IMAGE_NAME}"
                    }
                }
            }
        }
    }

    post {
        always {
            catchError(buildResult: 'FAILURE', message: 'Docker logout failed: An error occurred during the logout.') {
                node {
                    sh 'docker logout'
                }
            }
        }
    }
}
