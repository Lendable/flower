pipeline {
  agent { label 'jworker' }

  stages {
    stage('Build') {
      steps {
        ansiColor('xterm') {
          sh """make TAG="${GIT_COMMIT}" docker.build"""
        }
      }
    }

    stage('Publish') {
      when { tag "*" }
      steps {
        ansiColor('xterm') {
          sh """
            # Get git tag
            TAG=\$(git describe --candidates=0 --tags)

            # Authenticate to ECR
            eval \$(aws ecr get-login --registry-ids=177947534298 --region=eu-west-1 | sed 's/-e none//' | sed 's|https://||')

            # Publish the built image
            make TAG="${env.GIT_COMMIT}" PUSH_TAG="\${TAG}" docker.publish
          """
        }
      }
    }
  }

  post {
    cleanup {
      cleanWs()
    }
  }
}

