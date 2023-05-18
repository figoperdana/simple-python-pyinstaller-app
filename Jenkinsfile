def dockerImage
node {
    stage('Build') {
        checkout scm
        dockerImage = docker.image('python:2-alpine')
        dockerImage.inside {
            sh 'python -m py_compile sources/add2vals.py sources/calc.py'
            stash(name: 'compiled-results', includes: 'sources/*.py*')
        }
    }
    stage('Test') {
        dockerImage = docker.image('qnib/pytest')
        dockerImage.inside {
            sh 'py.test --junit-xml test-reports/results.xml sources/test_calc.py'
        }
    }
    stage('Deliver') { 
        dockerImage = docker.image('cdrx/pyinstaller-linux:python2')
        dockerImage.inside {
            dir(env.BUILD_ID) {
                unstash(name: 'compiled-results')
                sh 'pyinstaller -F add2vals.py'
                archiveArtifacts artifacts: "${env.BUILD_ID}/sources/dist/add2vals", onlyIfSuccessful: true
                sh 'rm -rf build dist'
            }
        }
    }
}
