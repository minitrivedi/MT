pipeline
{
  agent { label 'linux' }
  stages {
    stage('Create jar')
    {
      steps{
      sh 'javac HelloWorld/Main.java'
        sh 'jar cfm `pwd`/MyJar.jar Manifest.txt HelloWorld/*.class'
        sh 'java -jar `pwd`/MyJar.jar'
      }
    }
  }
}
