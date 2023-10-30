pipeline {
    agent {
        node {
            label 'docker-jenkins-slave'
        }
    }

    tools {
        maven 'mvn-3.8.5'
    }
    
    stages {
        stage('Cloning Stage') {
            steps {
                git 'https://github.com/aomarabdelaziz/trend-app.git'
            }
        }
        stage('Install Stage') {
            steps {
               mvn install
            }
        }
    }
}