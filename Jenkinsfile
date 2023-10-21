pipeline {
    agent any
    options {
        skipDefaultCheckout()
    }
    parameters {
        string(name:'GIT_URL', defaultValue:'https://github.com/nvtienanh/jenkins-agent-docker-kubectl.git', description:'The URL of the source Git repository to use.')
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
                    // extensions: [
                    //     [
                    //         $class: 'RelativeTargetDirectory',
                    //         relativeTargetDir: 'src',
                    //     ],
                    // ],
                    submoduleCfg: [],
                    userRemoteConfigs: [
                        [
                            url: params.GIT_URL,
                        ],
                    ],
                ])
            }
        }
        stage("Build docker") {
            agent {
                label 'docker-build'
            }
            steps {
                container(name: 'kaniko') {
                    sh '/kaniko/executor -f `pwd`/Dockerfile -c `pwd` --destination=nvtienanh/jnlp-from-kaniko:latest'
                }
            }
        }
    }
}