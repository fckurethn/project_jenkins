#!groovy

pipeline {
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
        timestamps()
    }
    stages {
        stage("Build and Run New Release") {
            steps {
              sh "a=`sudo docker ps | grep fckurethn/my-flask-app | awk '{prin\$1}'`; [ "\$a" = "" ] && echo nothing_to_stop || sudo docker stop \$a"
              sh "docker build -t fckurethn/my-flask-app:$TAG_NAME ."
              sh "docker run -d -p 8888:5000 fckurethn/my-flask-app:$TAG_NAME"
            }
        }
        stage("Push to DockerHub and Delete Old Image") {
            steps {
              sh "echo 'HERE WILL BE USEFUL CODE I PROMICE'"
            }
        }
    }
}
