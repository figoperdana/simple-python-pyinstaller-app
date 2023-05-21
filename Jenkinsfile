pipeline {
    agent none
    options {
        skipStagesAfterUnstable()
    }
    stages {
        stage('Build') {
            agent {
                docker {
                    image 'python:2-alpine'
                }
            }
            steps {
                sh 'python -m py_compile sources/add2vals.py sources/calc.py'
                stash(name: 'compiled-results', includes: 'sources/*.py*')
            }
        }
        stage('Test') {
            agent {
                docker {
                    image 'qnib/pytest'
                }
            }
            steps {
                sh 'py.test --junit-xml test-reports/results.xml sources/test_calc.py'
            }
            post {
                always {
                    junit 'test-reports/results.xml'
                }
            }
        }
        stage('Deliver') { 
            agent any
            environment { 
                VOLUME = "${env.WORKSPACE}/sources:/src"
                IMAGE = 'cdrx/pyinstaller-linux:python2'
            }
            steps {
                dir(path: env.BUILD_ID) { 
                    unstash(name: 'compiled-results') 
                    sh "docker run --rm -v ${VOLUME} ${IMAGE} 'pyinstaller -F add2vals.py'" 
                }
            }
            post {
                success {
                    archiveArtifacts "dist/add2vals" 
                    sh "docker run --rm -v ${VOLUME} ${IMAGE} 'rm -rf build dist'"
                }
            }
        }
        stage('Manual Approval') {
            agent any
            steps {
                input message: 'Lanjutkan ke tahap Deploy?', ok: 'Proceed'
            }
        }
        stage('Test before Deploy') { 
            agent {
                docker {
                    image 'qnib/pytest'
                }
            }
            steps {
                sh 'chmod +x ./jenkins/scripts/test.sh'
                sh './jenkins/scripts/test.sh'
            }
        }
        stage('Deploy') {
            agent any
            steps {
                script {
                    sh 'docker build -t my-python-app .'
                }
            }
        }
    }
}