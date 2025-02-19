pipeline
{
  agent { label 'linux' }
  stages {
    stage('Create jar')
    {
      steps{
      sh 'javac HelloWorld/Main.java'
        sh 'jar cfm `pwd`/MyJar.jar Manifest.txt HelloWorld/Main.class'
       // jar cfm /Users/minitrivedi/jenkins/workspace/Mini/Website-Docker/MyJar.jar Manifest.txt HelloWorld/Main.class

        sh 'java -jar `pwd`/MyJar.jar'
      }
    }
  }
}
