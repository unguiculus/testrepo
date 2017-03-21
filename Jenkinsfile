pipeline {
    agent any

    stages {
        stage('Build') {
            milestone()
            steps {
                sshagent(['ssh-key']) {
                    withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'artifactory-deployer-credentials',
                            usernameVariable: 'ARTIFACTORY_USER', passwordVariable: 'ARTIFACTORY_PASSWORD']]) {
                        withMaven(jdk: 'Java 8', maven: 'Maven 3.3.9', mavenLocalRepo: '.repository', mavenSettingsConfig: 'maven-settings') {
                            sh '''
                                fossa --verbose build \
                                --build-script=./build_rc.sh \
                                --version-script=./set_rc_version.sh \
                                --version-file=./target/app-version.properties \
                                || true
                            '''
                        }
                    }
                }
            }
        }

        stage('Code Analysis') {
            lock('code_analysis', inversePrecedence: true) {
                withMaven(jdk: 'Java 8', maven: 'Maven 3.3.9', mavenLocalRepo: '.repository', mavenSettingsConfig: 'maven-settings') {
                    sh 'mvn sonar:sonar -Dsonar.host.url=http://jenkins03.sc.smartcast.de:9000'
                }
                milestone()
            }
        }

        stage('Promote') {
            input "Promote build?"
            milestone()
            echo 'Promote'
        }
    }
}
