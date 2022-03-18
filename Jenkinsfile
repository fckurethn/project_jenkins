#!groovy
// Check ub1 properties
properties([disableConcurrentBuilds()])

pipeline {
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
        timestamps()
    }
    stages {
        stage("First step") {
            steps {
                sh 'docker build -t fckurethn/my-flask-app .'
            }
        }
        stage("Second step") {
            steps {
                sh 'docker run -d -p 8888:5000 fckurethn/my-flask-app'
            }
        }
    }
}
