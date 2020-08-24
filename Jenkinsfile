pipeline {
  agent any
  tools { 
        maven 'MAVEN_HOME'
        jdk 'JAVA_HOME'
  }
  stages {
    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace... */
      steps {
        checkout scm
      }
    }
    stage('Build') {
      steps {
        sh 'mvn -B -DskipTests clean package'
        sh 'echo $USER'
        sh 'echo whoami'
      }
    }
    stage('Docker Build') {
      steps {
        sh 'sudo docker build -t bank-service .'
        sh 'echo build finished'
      }
    }
   
    stage('push image to ECR'){
      steps {
        sh 'echo entered ecr'
       withDockerRegistry(credentialsId: 'ecr:us-east-1:aws-cred', url: 'http://102789521217.dkr.ecr.us-east-1.amazonaws.com/bank-service') {
          sh 'sudo usermod -aG docker jenkins'
          sh 'docker tag bank-service:latest 102789521217.dkr.ecr.us-east-1.amazonaws.com/bank-service:latest'
          sh 'docker push 102789521217.dkr.ecr.us-east-1.amazonaws.com/bank-service:latest'
        } 
      }
    }
  stage('deploy to ECR') {
      steps {
         node('eks-master-node'){
            checkout scm
         sh 'kubectl apply -f deployment.yaml' 
         sh 'kubectl apply -f service.yaml'  
         }
      }
    } 
  }
}
