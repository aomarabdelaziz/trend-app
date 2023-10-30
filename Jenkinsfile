pipeline {
    agent {
        node {
            label 'docker-jenkins-slave'
        }
    }

    tools {
        maven 'mvn-3.8.5'
    }

    environment {
        PATH = "$PATH"
    }
    
    stages {
        stage('Cloning Stage') {
            steps {
                git 'https://github.com/aomarabdelaziz/trend-app.git'
            }
        }
        stage('Build Stage') {
            steps {
               sh 'mvn clean deploy'
            }
        }
    }
}