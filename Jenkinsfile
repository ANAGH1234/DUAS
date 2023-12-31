pipeline {
    agent any
   

    environment {
        // Define your GitHub credentials ID
        GIT_CREDENTIALS = credentials('Github')
	    DOCKER_HOME = tool 'Docker'
            APP_NAME = "duas-social-site"
            RELEASE = "1.0.0"
            DOCKER_USER = "sagarupreti0307"
            DOCKER_PASS = 'dockerhub'
            IMAGE_NAME = "${DOCKER_USER}" + "/" + "${APP_NAME}"
            IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
	   
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
            withSonarQubeEnv('sonarqube-server') {
                def scannerHome = tool 'SonarScanner for MSBuild'

                // Ensure the correct .NET SDK version is available
                def dotnetHome = tool 'dotnet-sdk-5.0.0-rc.2.20475.5'

                sh "${dotnetHome}/dotnet ${scannerHome}/SonarScanner.MSBuild.dll begin /k:\"DUAS\""
                // Replace the following line with your actual build command
                sh 'dotnet build'
                sh "${dotnetHome}/dotnet ${scannerHome}/SonarScanner.MSBuild.dll end"
            }
        }
    }
}

        stage("Quality Gate"){
           steps {
               script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'jenkins-sonarqube-token'
                }	
            }

        }

        stage("Build & Push Docker Image") {
            steps {
                script {
		    def dockerCommand = "${DOCKER_HOME}/docker"
                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image = docker.build "${IMAGE_NAME}"
                    }

                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image.push("${IMAGE_TAG}")
                        docker_image.push('latest')
                    }
                }
            }

       }

	      stage("Trivy Scan") {
           steps {
               script {
	            sh ('docker run -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image sagarupreti0307/duas-social-site:latest --no-progress --scanners vuln  --exit-code 0 --severity HIGH,CRITICAL --format table')
               }
           }
       }

	     stage ('Cleanup Artifacts') {
           steps {
               script {
                    sh "docker rmi ${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker rmi ${IMAGE_NAME}:latest"
               }
          }
       }

    }
}
