pipeline {
    agent { label 'jenkins-agent' }
    
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
                bat 'nuget restore'
            }
        }

        stage('Build') {
            steps {
                // Build the .NET project
                bat 'msbuild /p:Configuration=Release'
            }
        }

        stage('Run Tests') {
            steps {
                // Run tests for the .NET project
                bat 'msbuild /t:VSTest'
            }
        }
    }
}

        
