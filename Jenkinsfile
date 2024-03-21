pipeline {
    agent {
        node {
            label 'maven'
        }
    }
environment {
    PATH = "/opt/apache-maven-3.9.6/bin:$PATH"
}

    stages {
        stage("build"){
            steps {
                echo "----------build started-------------"
                sh 'mvn clean deploy -Dmaven.test.skip=true'
                echo "-----------build complete----------"
            }
        }
    stage('SonarQube analysis') {
    environment {
    def scannerHome = tool 'Losteroid-sonar-scanner';
    }
    steps{
    withSonarQubeEnv('Losteroid-sonarqube-server') { // If you have configured more than one global server connection, you can specify its name
      sh "${scannerHome}/bin/sonar-scanner"
    }
    }
  }
}
}
