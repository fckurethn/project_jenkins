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
              sh "./test.sh"
              sh "docker build -t fckurethn/my-flask-app:$GIT_COMMIT ."
              sh "docker run -d -p 8888:5000 fckurethn/my-flask-app:$GIT_COMMIT"
            }
        }
        stage("Push to DockerHub and Delete Old Image") {
            steps {
              sh "echo 104f4abM\_ | docker login -u "fckurethn" --password-stdin"
              sh "docker push fckurethn/my-cat-app:v$GIT_COMMIT"
              sh "echo 'HERE WILL BE USEFUL CODE I PROMICE'"
            }
        }
    }
}
