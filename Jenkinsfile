pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                milestone(0)
                sshagent(['ssh-key']) {
                    withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'artifactory-deployer-credentials',
                            usernameVariable: 'ARTIFACTORY_USER', passwordVariable: 'ARTIFACTORY_PASSWORD']]) {
                        withMaven(jdk: 'Java 8', maven: 'Maven 3.3.9', mavenLocalRepo: '.repository', mavenSettingsConfig: 'maven-settings') {
                            environment {
                                ARTIFACTORY_API_KEY = env.ARTIFACTORY_PASSWORD
                            }

                            echo env.ARTIFACTORY_PASSWORD

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
            steps {
                lock(resource: 'code_analysis', inversePrecedence: true) {
                    withMaven(jdk: 'Java 8', maven: 'Maven 3.3.9', mavenLocalRepo: '.repository', mavenSettingsConfig: 'maven-settings') {
                        sh 'mvn sonar:sonar -Dsonar.host.url=http://jenkins03.sc.smartcast.de:9000'
                    }
                    milestone(1)
                }
            }
        }

        stage('Promote') {
            steps {
                milestone(2)
                input "Promote build?"
                milestone(3)
                echo 'Promote'
            }
        }
    }
}
