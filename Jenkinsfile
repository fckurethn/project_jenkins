#!groovy

pipeline {
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '3', artifactNumToKeepStr: '3'))
        timestamps()
    }
    stages {
        stage("Build New Release") {
            steps {
              sh '''
              docker build -t fckurethn/my-flask-app:$GIT_COMMIT .
              '''
            }
        }
        stage("Push to DockerHub and Delete Old Image") {
            steps {
              sh '''
              echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin
              ./remove_images_dockerhub.sh
              docker push fckurethn/my-flask-app:$GIT_COMMIT
              docker image prune -a -f
              '''
            }
        }
        stage("Deploy") {
            steps {
              sshagent(['ubuntu(deploy)']) {
                sh '''
                a=`docker ps | grep fckurethn/my-flask-app | awk '{print $1}'`; [ "$a" != "" ] && docker stop $a || echo 'There is no running container, go further'
                docker rmi -f $(docker images -q)
                echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin
                docker pull fckurethn/my-flask-app:$GIT_COMMIT
                docker run -d -p 80:5000 fckurethn/my-flask-app:$GIT_COMMIT
                '''
              }
          }
      }
  }
}
