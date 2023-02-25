pipeline {
    agent { 
        label "swarm"
    }

    environment {
        REPOSITORY_URL = "https://github.com/buxiaomo/RuoYi.git"
    }

    parameters{
        string(
            description: "version of RuoYi-Cloud ?",
            name: "version",
            defaultValue: "v3.6.2",
        )
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: '15'))
    }

    stages {
        stage('checkout') {
            steps {
                retry(3) {
                    checkout scmGit(branches: [[name: "main"]], extensions: [[$class: 'CleanBeforeCheckout'],[$class: 'CloneOption', timeout: 120, shallow: true, noTags: true, depth: 1]], submoduleCfg: [], userRemoteConfigs: [[url: "${env.REPOSITORY_URL}"]])
                    checkout scmGit(branches: [[name: "refs/tags/${params.version}"]], extensions: [[$class: "RelativeTargetDirectory", relativeTargetDir: "RuoYi-Cloud"]], userRemoteConfigs: [[url: "https://gitee.com/y_project/RuoYi-Cloud.git"]])
                }
            }
        }

        stage('build package') {
            steps {
                dir('RuoYi-Cloud') {
                    withDockerContainer('maven:3.9.0') {
                        sh "mvn clean package -Dmaven.test.skip=true"
                    }
                }
            }
        }

        stage('build image') {
            parallel {
                stage('build ruoyi-gateway') {
                    steps {
                        sh "docker build -t buxiaomo/ruoyi-gateway:${params.version} -f gateway.Dockerfile ."
                        withDockerRegistry(credentialsId: 'dockerhub', url: 'index.docker.io') {
                            sh "docker push buxiaomo/ruoyi-gateway:${params.version}"
                        }
                    }
                }
                stage('build ruoyi-auth') {
                    steps {
                        sh "docker build -t buxiaomo/ruoyi-auth:${params.version} -f auth.Dockerfile ."
                        withDockerRegistry(credentialsId: 'dockerhub', url: 'index.docker.io') {
                            sh "docker push buxiaomo/ruoyi-auth:${params.version}"
                        }
                    }
                }
                stage('build ruoyi-modules-system') {
                    steps {
                        sh "docker build -t buxiaomo/ruoyi-modules-system:${params.version} -f modules-system.Dockerfile ."
                        withDockerRegistry(credentialsId: 'dockerhub', url: 'index.docker.io') {
                            sh "docker push buxiaomo/ruoyi-modules-system:${params.version}"
                        }
                    }
                }
                stage('build ruoyi-modules-gen') {
                    steps {
                        sh "docker build -t buxiaomo/ruoyi-modules-gen:${params.version} -f modules-gen.Dockerfile ."
                        withDockerRegistry(credentialsId: 'dockerhub', url: 'index.docker.io') {
                            sh "docker push buxiaomo/ruoyi-modules-gen:${params.version}"
                        }
                    }
                }
                stage('build ruoyi-modules-job') {
                    steps {
                        sh "docker build -t buxiaomo/ruoyi-modules-job:${params.version} -f modules-job.Dockerfile ."
                        withDockerRegistry(credentialsId: 'dockerhub', url: 'index.docker.io') {
                            sh "docker push buxiaomo/ruoyi-modules-job:${params.version}"
                        }
                    }
                }
                stage('build ruoyi-modules-file') {
                    steps {
                        sh "docker build -t buxiaomo/ruoyi-modules-file:${params.version} -f modules-file.Dockerfile ."
                        withDockerRegistry(credentialsId: 'dockerhub', url: 'index.docker.io') {
                            sh "docker push buxiaomo/ruoyi-modules-file:${params.version}"
                        }
                    }
                }
                stage('build ruoyi-visual-monitor') {
                    steps {
                        sh "docker build -t buxiaomo/ruoyi-visual-monitor:${params.version} -f visual-monitor.Dockerfile ."
                        withDockerRegistry(credentialsId: 'dockerhub', url: 'index.docker.io') {
                            sh "docker push buxiaomo/ruoyi-visual-monitor:${params.version}"
                        }
                    }
                }
            }
        }
    }
}
