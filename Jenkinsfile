def registry = 'https://trendapp.jfrog.io'
def imageName = 'trendapp.jfrog.io/abdelaziz-docker-local/ttrend'
def version   = '2.1.4'

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

        stage ("jar Publish") {
            steps {
                script {
                        echo '<--------------- Jar Publish Started --------------->'
                        server = Artifactory.newServer url:registry+"/artifactory" ,  credentialsId:"jfrog-cred"
                        properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}";
                        uploadSpec = """{
                            "files": [
                                {
                                "pattern": "jarstaging/(*)",
                                "target": "libs-release-local/{1}",
                                "flat": "false",
                                "props" : "${properties}",
                                "exclusions": [ "*.sha1", "*.md5"]
                                }
                            ]
                        }"""
                        buildInfo = server.upload(uploadSpec)
                        buildInfo.env.collect()
                        server.publishBuildInfo(buildInfo)
                        echo '<--------------- Jar Publish Ended --------------->'  
                }
            }   
        }


        stage(" Docker Build ") {
            steps {
                script {
                echo '<--------------- Docker Build Started --------------->'
                app = docker.build(imageName+":"+version)
                echo '<--------------- Docker Build Ends --------------->'
                }
            }
        }

        stage (" Docker Publish "){
                steps {
                    script {
                    echo '<--------------- Docker Publish Started --------------->'  
                        docker.withRegistry(registry, 'jfrog-cred'){
                            app.push()
                        }    
                    echo '<--------------- Docker Publish Ended --------------->'  
                    }
                }
            }
    }
}
