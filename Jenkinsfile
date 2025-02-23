pipeline {
    agent { label 'linux' }
    
    environment {
        DOCKER_IMAGE = 'my-nginx-image'
        DOCKER_TAG = 'latest'
        DOCKER_HUB_REPO = 'mtrivedi2093/testwebsite'
        DOCKER_CREDENTIALS = 'mtrivedi2093'  // Jenkins credentials ID
    }
    
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t "${DOCKER_IMAGE}:${DOCKER_TAG}" .'
                        }
                 }
        }
        
        stage('Run Docker Container') {
            steps {
                script {
                  sh 'docker run -d -p 8082:80 my-nginx-image'
                }
            }
        }
        
        stage('Test Nginx') {
            steps {
                script {
                    // Wait for the Nginx server to be up and running
                    sh "curl -s http://localhost:8082"
                }
            }
        }
         stage('Login to Docker Hub') {
            steps {
                script {
                    // Login to Docker Hub using Jenkins credentials
                    withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS}", usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Tag the built image with your Docker Hub repository
                   // docker.tag("${DOCKER_IMAGE}:${DOCKER_TAG}", "${DOCKER_HUB_REPO}:${DOCKER_TAG}")

                    sh "docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKER_HUB_REPO}:${DOCKER_TAG}"
                    // Push the image to Docker Hub
                    sh "docker push ${DOCKER_HUB_REPO}:${DOCKER_TAG}"
                }
            }
        }
        stage('create pod'){
            steps{
                script{
                    sh 'kubectl get nodes'
                     withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS}", usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                         sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                   // sh 'kubectl create secret docker-registry my-docker-secret \
//  --docker-server=https://index.docker.io/v1/ --docker-username=<your-dockerhub-username> --docker-password=<your-dockerhub-password> 

                    sh 'kubectl apply -f nginx-deployment.yaml'
                     }
                    sh 'kubectl get pods'
                    sh 'kubectl get svc'
                }
            }
        }
       /* stage('Cleanup') {
            steps {
                script {
                    // Optionally, remove the container after the test
                    sh "docker ps -q --filter 'ancestor=${DOCKER_IMAGE}:${DOCKER_TAG}' | xargs docker rm -f"
                }
            }
        }*/
    }
    
    /*post {
        always {
            // Clean up the image if needed
            sh "docker rmi -f ${DOCKER_IMAGE}:${DOCKER_TAG}"
        }
    }*/
}
