#!groovy

pipeline {
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
        timestamps()
    }
    stages {
        stage("Stop Previous Container") {
            steps {
              sh "docker stop \$(docker ps | grep fckurethn/my-flask-app | awk '{print\$1}')"
            }
        }
        stage("Build and Run New release") {
            steps {
                sh "docker build -t fckurethn/my-flask-app:$BUILD_ID ."
                sh "docker run -d -p 8888:5000 fckurethn/my-flask-app:$BUILD_ID"
            }
        }
    }
}
