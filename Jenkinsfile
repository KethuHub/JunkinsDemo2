pipeline {
    agent any

    environment {
        IMAGE_NAME = "student-site-nginx"
        CONTAINER_NAME = "student-site-nginx"
        HOST_PORT = "8085"
        CONTAINER_PORT = "80"
    }

    stages {

        stage('Checkout Source') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                bat """
                docker build -t %IMAGE_NAME% .
                """
            }
        }

        stage('Stop Existing Container (if any)') {
            steps {
                echo "Stopping old container if it exists..."
                bat """
                docker stop %CONTAINER_NAME% || exit 0
                docker rm %CONTAINER_NAME% || exit 0
                """
            }
        }

        stage('Run Docker Container') {
            steps {
                echo "Running Docker container..."
                bat """
                docker run -d -p %HOST_PORT%:%CONTAINER_PORT% --name %CONTAINER_NAME% %IMAGE_NAME%
                """
            }
        }
    }

    post {
        success {
            echo "Docker container deployed successfully."
            echo "Access the website at: http://localhost:8085"
        }
        failure {
            echo "Docker pipeline failed."
        }
    }
}
