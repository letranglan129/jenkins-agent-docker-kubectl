pipeline {
    agent any
    options {
        skipDefaultCheckout()
    }
    parameters {
        string(name:'GIT_URL', defaultValue:'https://github.com/letranglan129/jenkins-agent-docker-kubectl.git', description:'The URL of the source Git repository to use.')
        string(name:'GIT_BRANCH', defaultValue:'main', description:'The branch in the source Git repository to use.')
    }
    stages {
        stage("Checkout") {
            steps {
                checkout(changelog: false, poll: false, scm: [
                    $class: 'GitSCM',
                    branches: [
                        [name: params.GIT_BRANCH],
                    ],
                    doGenerateSubmoduleConfigurations: false,
                    submoduleCfg: [],
                    userRemoteConfigs: [
                        [
                            url: params.GIT_URL,
                        ],
                    ],
                ])
                stash name: 'sources', includes: '**', excludes: '**/.git,**/.git/**'
            }
        }
        stage("Build docker") {
            agent {
                label 'docker-build'
            }
            steps {
                unstash 'sources'
                container(name: 'kaniko') {
                    sh 'ls'
                    sh 'echo $PWD'
                    sh 'ls /home/jenkins/agent'
                    sh 'ls /kaniko/.docker'
                    sh '/kaniko/executor --context=`pwd` --dockerfile=`pwd`/Dockerfile --destination=letranglan129/jnlp-from-kaniko:latest'
                }
            }
        }
    }
}
