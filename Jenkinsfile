pipeline {
  agent any
  environment {
    DEPLOY_PATH = "/home/deploy_demo/myapp"
    GIT_REPO = "git@github.com:nguyenvanlam2003/DemoJenkins.git"
    SERVER = "deploy_demo@192.168.33.128"
  }

  stages {
    stage('Pull code') {
      steps {
        sshagent(['deploy_demo-key']) {
          sh """
            ssh -o StrictHostKeyChecking=no ${SERVER} << 'EOF'
              if [ ! -d ${DEPLOY_PATH} ]; then
                git clone ${GIT_REPO} ${DEPLOY_PATH}
              else
                cd ${DEPLOY_PATH} && git pull origin main
              fi
            EOF
          """
        }
      }
    }

    stage('Build and Deploy') {
      steps {
        sshagent(['deploy_demo-key']) {
          sh """
            ssh -o StrictHostKeyChecking=no ${SERVER} << 'EOF'
              cd ${DEPLOY_PATH}
              docker-compose down
              docker-compose up -d --build
            EOF
          """
        }
      }
    }
  }
}
