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
        }
        stage('newman') {
            steps {
                sh 'newman run Restful_Booker.postman_test_run.json --environment Restful_Booker.postman_environment.json --reporters junit'
            }
            post {
                always {
                junit '**/*xml'
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