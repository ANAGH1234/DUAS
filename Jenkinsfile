pipeline {
    agent any

    stages {
        stage("Cleanup Workspace") {
            steps {
                cleanWs()
            }
        }

        stage("Checkout from SCM") {
            steps {
                git branch: 'main', credentialsId: 'Github', url: 'https://github.com/ANAGH1234/DUAS'
            }
        }

        stage("Build Application") {
            steps {
                sh "dotnet build --configuration Release --no-restore"
            }
        }

        stage("Test Application") {
            steps {
                sh "dotnet test --no-build --verbosity normal"
            }
        }
    }
}
