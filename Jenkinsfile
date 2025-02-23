pipeline {
    agent { label 'linux' }
    
    environment {
        DOCKER_IMAGE = 'my-nginx-image'
        DOCKER_TAG = 'latest'
    }
    
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'ls -ltr'
                    // Build the Docker image using the Dockerfile in the current directory
                 //   docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                    sh 'docker build -t "${DOCKER_IMAGE}:${DOCKER_TAG}" .'
                        }
                 }
        }
        
        stage('Run Docker Container') {
            steps {
                script {
                    // Run the Nginx container from the built image
                    // Here, we expose port 8080 and map it to the container's port 80
                  //  docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").run('-d -p 8080:80')
                  sh 'docker run -d -p 8081:80 my-nginx-image'
                }
            }
        }
        
        stage('Test Nginx') {
            steps {
                script {
                    // Wait for the Nginx server to be up and running
                    sh "curl -s http://localhost:8080"
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
