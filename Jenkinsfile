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
              docker push fckurethn/my-flask-app:$GIT_COMMIT
              ./remove_images_dockerhub.sh
              docker image prune -a -f
              '''
            }
        }
        stage("Deploy") {
            steps {
              sshPublisher(publishers: [sshPublisherDesc(configName: 'deploy', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: './test.sh')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
              sshagent(['ubuntu(deploy)']) {
                sh '''
                ./test.sh
                echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin
                docker pull fckurethn/my-flask-app:$GIT_COMMIT
                docker run -d -p 80:5000 fckurethn/my-flask-app:$GIT_COMMIT
                '''
              }
          }
      }
  }
}
