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
 junit '**/TEST*.xml'
 }
 }
 }
 }
}
