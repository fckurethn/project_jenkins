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
              docker push fckurethn/my-flask-app:1
              ./remove_images_dockerhub.sh
              docker image prune -a -f
              '''
            }
        }
        stage("Deploy") {
          steps {
            sshPublisher(publishers: [sshPublisherDesc(configName: 'deploy', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '''
            echo 104f4abM_ | docker login -u fckurethn --password-stdin
            docker pull fckurethn/my-flask-app:1
            docker run -d -p 80:5000 fckurethn/my-flask-app:1
            ''', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
          }
        }
    }
}
//
