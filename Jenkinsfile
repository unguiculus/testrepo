pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'artifactory-deployer-credentials',
                                  usernameVariable: 'ARTIFACTORY_USER', passwordVariable: 'ARTIFACTORY_PASSWORD']]) {

                    withMaven(jdk: 'Java 8', maven: 'Maven 3.3.9', mavenLocalRepo: '.repository', mavenSettingsConfig: 'maven-settings') {
                        sh './build_rc.sh'
                    }
                }

                junit '**/target/surefire-reports/TEST-*.xml'
            }
        }
    }
}
