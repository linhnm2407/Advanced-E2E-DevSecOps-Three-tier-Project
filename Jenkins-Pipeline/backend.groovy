pipeline {
    agent any
    tools {
        jdk 'jdk18'
        nodejs 'nodejs'
    }
    environment {
        SCANNER_HOME=tool 'sonar-scanner'
        AWS_ACCOUNT_ID = credentials('ACCOUNT_ID')
        AWS_ECR_REPO_NAME = credentials('ECR_BACKEND')
        AWS_DEFAULT_REGION = 'ap-southeast-1'
        REPOSITORY_URI = "${ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/"
    }

    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }

        stage('Checkout Git') {
            steps {
                git branch: 'master', url: 'https://github.com/linhnm2407/Advanced-E2E-DevSecOps-Three-tier-Project.git'
            }
        }

         stage('Sonarqube-Analysis') {
            steps {
                
            }
         }
    }

}
