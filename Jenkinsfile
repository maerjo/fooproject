pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/maerjo/fooproject.git'
                }
        }
        stage('Build') {
            steps {
                sh "mvn compile"
            }
        }
        stage('Test') {
            steps {
                sh "mvn test"
            }
            post {
                 always {
                 junit '**/*xml'
                 }
            }
        }
        stage('API Postman tests using newman') {
            steps {
                sh 'newman run Restful_Booker.postman_test_run.json --environment Restful_Booker.postman_environment.json --reporters junit'
            }
            post {
                always {
                junit '**/*xml'
                }
            }
        }
        stage('RobotFramework tests') {
                    steps {
                        sh 'robot -d results --include bokabil --variable BROWSER:headlesschrome Tests/labb3.robot'
                    }
                    post {
                        always {
                            script {
                                  step(
                                        [
                                          $class              : 'RobotPublisher',
                                          outputPath          : 'results',
                                          outputFileName      : '**/output.xml',
                                          reportFileName      : '**/report.html',
                                          logFileName         : '**/log.html',
                                          disableArchiveOutput: false,
                                          passThreshold       : 50,
                                          unstableThreshold   : 40,
                                          otherFiles          : "**/*.png,**/*.jpg",
                                        ]
                                   )
                            }
                        }
                    }
                }
    }
    post {
        always {
            junit '**/TEST*.xml'
        }
    }
}
