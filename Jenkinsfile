#!groovy
// Check ub1 properties
properties([disableConcurrentBuilds()])

pipeline {
    agent { 
       label any
       }
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
                sh 'run -d -p 8888:5000 fckurethn/my-flask-app'
            }
        }
    }
}
