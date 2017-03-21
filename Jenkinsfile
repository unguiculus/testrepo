pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sshagent(['ssh-key']) {

                    withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'artifactory-deployer-credentials',
                                      usernameVariable: 'ARTIFACTORY_USER', passwordVariable: 'ARTIFACTORY_PASSWORD']]) {

                        withMaven(jdk: 'Java 8', maven: 'Maven 3.3.9', mavenLocalRepo: '.repository', mavenSettingsConfig: 'maven-settings') {
                            sh '''
                                fossa --verbose build \
                                --build-script=./build_rc.sh \
                                --version-script=./set_rc_version.sh \
                                --version-file=./target/app-version.properties
                            '''
                        }
                    }
                }
            }
        }
    }
}
