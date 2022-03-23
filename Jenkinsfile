#!groovy

pipeline {
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
        timestamps()
    }
    stages {
        stage("Build of the image") {
            steps {
                sh "docker build -t fckurethn/my-flask-app:$BUILD_ID ."
            }
        }
        stage("Run the container") {
            steps {
                sh "docker run -d -p 8888:5000 fckurethn/my-flask-app:$BUILD_ID"
            }
        }
    }
}
