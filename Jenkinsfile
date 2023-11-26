pipeline {
    agent any

    environment {
        // Define your GitHub credentials ID
        GIT_CREDENTIALS = credentials('Github')
    }

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    // Remove existing files
                    deleteDir()
checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/ANAGH1234/DUAS.git']]])

                }
            }
        }

        stage('Build and Test') {
            steps {
                script {
                    // Change to the API directory
                    dir('DUAS/API') {
                        // Restore and build API
                        sh 'dotnet restore'
                        sh 'dotnet build --configuration Release --no-restore'
                    }

                    // Change to the Application directory
                    dir('DUAS/Application') {
                        // Build Application
                        sh 'dotnet build --configuration Release --no-restore'
                    }

                    // Change to the Domain directory
                    dir('DUAS/Domain') {
                        // Build Domain
                        sh 'dotnet build --configuration Release --no-restore'
                    }

                    // Change to the Persistence directory
                    dir('DUAS/Persistence') {
                        // Build Persistence
                        sh 'dotnet build --configuration Release --no-restore'
                    }

                    // Run tests
                    sh 'dotnet test --no-build --verbosity normal'
                }
            }
        }
    }
}
