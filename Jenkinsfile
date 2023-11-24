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
                // Restore NuGet packages for the .NET Core project
                sh 'dotnet restore'
            }
        }
        
        stage('Build') {
            steps {
                // Build the .NET Core project
                sh 'dotnet build --configuration Release'
            }
        }
        
        stage('Run Tests') {
            steps {
                // Run tests for the .NET Core project
                sh 'dotnet test --configuration Release --logger "trx;LogFileName=testresults.trx"'
            }
            post {
                always {
                    // Archive the test results
                    archiveArtifacts 'testresults.trx'
                }
            }
        }
    }
    }
}

        
