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
        stage('Build Stage') {
            steps {
               sh 'mvn clean deploy'
            }
        }
        stage("test"){
            steps{
                echo "----------- unit test started ----------"
                sh 'mvn surefire-report:report'
                echo "----------- unit test Complted ----------"
            }
        }
        stage('SonarQube analysis') {
            environment {
                scannerHome = tool 'sonarqube-scanner'
            }
            steps{
                withSonarQubeEnv('sonarqube-server') { 
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }
    }
}
