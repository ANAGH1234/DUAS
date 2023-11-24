pipeline {
    agent none
    stages {
        stage('Build') {
            agent {
                docker {
                    image 'mcr.microsoft.com/dotnet/sdk:5.0'
                    args '--name my-dotnet-container'
                }
            }
            steps {
                sh 'dotnet build --configuration Release'
            }
        }
    }
}
