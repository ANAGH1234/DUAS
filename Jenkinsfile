pipeline {
    agent any

    environment {
        // Define your GitHub credentials ID
        GIT_CREDENTIALS = credentials('Github')
    }


    stages {


        stage("Cleanup Workspace"){
                steps {
                cleanWs()
                }
        }
             
         stage("Checkout from SCM"){
                steps {
                    git branch: 'main', credentialsId: 'Github', url: 'https://github.com/ANAGH1234/DUAS'
                }
        }

        stage('Build and Test') {
            steps {
                script {
                    // Change to the API directory
                    dir('API') {
                        // Restore and build API
                        sh 'dotnet restore'
                        sh 'dotnet build --configuration Release --no-restore'
                    }

                    // Change to the Application directory
                    dir('Application') {
                        // Build Application
                        sh 'dotnet build --configuration Release --no-restore'
                    }

                    // Change to the Domain directory
                    dir('Domain') {
                        // Build Domain
                        sh 'dotnet build --configuration Release --no-restore'
                    }

                    // Change to the Persistence directory
                    dir('Persistence') {
                        // Build Persistence
                        sh 'dotnet build --configuration Release --no-restore'
                    }

                    // Run tests
                    sh 'dotnet test --no-build --verbosity normal'
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    // Run SonarQube analysis
                    withSonarQubeEnv() {
                        def scannerHome = tool 'SonarScanner for MSBuild'
                        sh "dotnet ${scannerHome}/SonarScanner.MSBuild.dll begin /k:\"DUAS\""
                        sh 'dotnet build'
                        sh "dotnet ${scannerHome}/SonarScanner.MSBuild.dll end"
                    }
                }
            }
        }
    }
}
