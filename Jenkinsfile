pipeline {
    agent any

    stages {
        stage('Deploy HTML to IIS') {
            steps {
                powershell '''
                Write-Host "Deploying files to IIS..."

                $source = "C:\\AILabs4U\\JunkinsDemo2"
                $destination = "C:\\inetpub\\wwwroot"

                if (!(Test-Path $source)) {
                    Write-Error "Source folder not found: $source"
                    exit 1
                }

                if (!(Test-Path $destination)) {
                    Write-Error "IIS wwwroot not found: $destination"
                    exit 1
                }

                Copy-Item "$source\\*" $destination -Recurse -Force

                Write-Host "Deployment completed successfully."
                '''
            }
        }
    }

    post {
        success {
            echo 'Website deployed to IIS successfully.'
        }
        failure {
            echo 'Deployment failed.'
        }
    }
}
