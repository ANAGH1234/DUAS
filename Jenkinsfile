pipeline {
    agent { label 'Jenkins-Agent' }
    
    stages {
        stage("Cleanup Workspace") {
            steps {
                cleanWs()
            }
        }

        stage('Checkout') {
            steps {
                // Checkout your code from the Git repository
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/ANAGH1234/DUAS.git'
            }
        }

        stage('Restore Packages') {
            steps {
                // Restore NuGet packages for the project
                sh 'dotnet restore'
            }
        }

        stage('Build') {
            steps {
                // Build the .NET project
                sh 'dotnet build --configuration Release'
            }
        }
    }
}

        
