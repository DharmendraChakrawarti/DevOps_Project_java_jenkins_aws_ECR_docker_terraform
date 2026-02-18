pipeline {
    agent any

    environment {
        IMAGE_NAME = "student-app:latest"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                url: 'https://github.com/DharmendraChakrawarti/DevOps_Project_java_jenkins_aws_ECR_docker_terraform.git'
            }
        }

        stage('Build Maven') {
            steps {
                dir('student-app') {
                    sh 'mvn clean package -DskipTests'
                }
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t $IMAGE_NAME -f Dockerfile .'
            }
        }

       stage('Push to ECR') {
    steps {
        withCredentials([
            string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'),
            string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')
        ]) {
            sh '''
            export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
            export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
            export AWS_DEFAULT_REGION=ap-south-1

            aws ecr get-login-password --region ap-south-1 | \
            docker login --username AWS --password-stdin 268271485908.dkr.ecr.ap-south-1.amazonaws.com

            docker tag student-app:latest 268271485908.dkr.ecr.ap-south-1.amazonaws.com/student-app:latest

            docker push 268271485908.dkr.ecr.ap-south-1.amazonaws.com/student-app:latest
            '''
        }
    }
}

       
    }

    post {
        success {
            echo "✅ CI PIPELINE SUCCESSFUL"
        }
        failure {
            echo "❌ BUILD FAILED"
        }
    }
}
