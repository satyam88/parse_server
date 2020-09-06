pipeline {

    options {
        buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '5'))
    }
    agent any

    tools {
        maven 'maven_3.6.3'
    }

    stages {
        stage('Code Compilation') {
            steps {
                sh 'mvn clean compile'
            }
        }
        stage('QA Execution') {
            steps {
                sh 'mvn clean test'
            }
        }
        stage('Code Package') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Build Docker Image') {
           steps {
                sh 'docker build -t parse_server .'
           }
         }
        stage('Tag Docker Image') {
           steps {
                sh 'docker build -t satyam88/parse_server .'
           }
         }

        stage('Upload Docker Image to AWS ECR') {
            steps {
			   script {
			      withDockerRegistry([credentialsId:'ecr:ap-south-1:ecr-credentials', url:"https://719580743266.dkr.ecr.ap-south-1.amazonaws.com"]){
                  sh """
                  echo "List the docker images present in local"
                  docker images
				  echo "Tagging the Docker Image: In Progress"
				  docker tag parse_server:latest 719580743266.dkr.ecr.ap-south-1.amazonaws.com/parse_server:latest
				  echo "Tagging the Docker Image: Completed"
				  echo "Push Docker Image to ECR : In Progress"
				  docker push 719580743266.dkr.ecr.ap-south-1.amazonaws.com/parse_server:latest
				  echo "Push Docker Image to ECR : Completed"
				  """
				  }
                }
            }
		}
        stage('Deploy App to K8s Cluster') {
            steps {
                sh 'kubectl apply -f kubernetes/prod'
            }
    }
}