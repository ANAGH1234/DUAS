pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                // Checkout your code from the Git repository
                git 'https://github.com/your-username/your-dotnet-project.git'
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
        
        stage('Run Tests') {
            steps {
                // Run tests if applicable
                // Example command: dotnet test YourProject.Tests.csproj
                sh 'dotnet test'
            }
        }
        
        stage('Publish') {
            steps {
                // Publish the project
                // Example command: dotnet publish -c Release -o output_directory
                sh 'dotnet publish --configuration Release --output publish_directory'
            }
        }
        
        stage('Run Application') {
            steps {
                // Run the compiled application
                // Example command: dotnet YourProject.dll
                sh 'cd publish_directory && dotnet YourProject.dll' // Replace with your project's executable name
            }
        }
    }
}
