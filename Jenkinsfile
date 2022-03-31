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
              sshagent(['deploy']) {
                sh  'ssh -o StrictHostKeyChecking=no $PROD_USER@$PROD_IP uptime'
                sh '''
                ssh $PROD_USER@$PROD_IP ./test.sh
                ssh $PROD_USER@$PROD_IP docker rmi -f $(docker images -q)
                ssh $PROD_USER@$PROD_IP echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin
                ssh $PROD_USER@$PROD_IP docker pull fckurethn/my-flask-app:$GIT_COMMIT
                ssh $PROD_USER@$PROD_IP docker run -d -p 80:5000 fckurethn/my-flask-app:$GIT_COMMIT
                '''
              }
          }
      }
  }
}
