pipeline {
    agent {
        node {
            label 'docker-jenkins-slave'
        }
    }
    
    stages {
        stage('Hello') {
            steps {
                git 'https://github.com/aomarabdelaziz/trend-app.git'
            }
        }
    }
}