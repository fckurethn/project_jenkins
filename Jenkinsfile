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
              sh '''
              ./test.sh
              docker build -t fckurethn/my-flask-app:$GIT_COMMIT .
              docker run -d -p 8888:5000 fckurethn/my-flask-app:$GIT_COMMIT
              '''
            }
        }
        stage("Push to DockerHub and Delete Old Image") {
            steps {
              sh '''
              echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin
              docker push fckurethn/my-flask-app:$GIT_COMMIT
              ./remove_images_dockerhub.sh
              '''
            }
        }
    }
}
