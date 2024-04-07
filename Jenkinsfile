pipeline {
    agent {
        node {
           label 'maven-slave'
        }
    }

    stages {
        stage('Clone-code') {
            steps {
                git branch: 'main', url: 'https://github.com/Chirag3030/tweet-trend-new-1.git'
            }
        }
    }
}