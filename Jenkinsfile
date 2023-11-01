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
                echo "----------- build started ----------"
                sh 'mvn clean deploy -Dmaven.test.skip=true'
                echo "----------- build started ----------"
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
        stage ("Quality Gate") {
            steps {
                script {
                    timeout(time: 1 , unit: 'HOURS') {
                        qg = waitForQualityGate() // Reuse taskId previouslsy collected by withSonarQubeEnv
                        if (qg.status != 'OK') {
                             error "Pipeline aborted due to quality gate failure: ${qg.status}"
                        }
                    }
                }
            }
        }
        
    }
}
