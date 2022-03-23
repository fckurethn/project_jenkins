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
                sh "docker build -t fckurethn/my-flask-app:\$(cat version) ."
                sh "docker run -d -p 8888:5000 fckurethn/my-flask-app:\$(cat version)"
            }
        }
        stage("Update Build Version") {
            steps{
              sh "cat version | sed -r "s/[0-9]+\$/$BUILD_ID/w version""
            }
        }
    }
}
