pipeline {
  agent { label 'HITC-Worker' }

  stages {
    stage('Info') {
      steps {
        echo '🔍 Running on HITC-Worker'
      }
    }

    stage('Deploy with Docker Compose') {
      steps {
        // Thư mục làm việc mặc định là $WORKSPACE, nơi bạn đã checkout code
        dir("${env.WORKSPACE}") {
          sh '''
            # Dừng & remove mọi container cũ (bỏ lỗi nếu không có)
            docker compose down --remove-orphans || true

            # Xây dựng image (nếu Dockerfile có thay đổi) và khởi lại
            docker compose up -d --build

            # Hiển thị trạng thái container
            docker compose ps

            # Dọn dẹp toàn bộ resource không dùng
            docker system prune -f
            docker volume prune -f
            docker image prune -a -f
          '''
        }
      }
    }
  }

  post {
    success {
      echo '🎉 Deployment completed successfully on HITC-Worker'
    }
    failure {
      echo '❌ Deployment failed – check the console output above'
    }
  }
}
