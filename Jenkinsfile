pipeline {
    agent any

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
                    checkout scmGit(branches: [[name: 'main']], extensions: [], userRemoteConfigs: [[url: "${env.REPOSITORY_URL}"]])
                    checkout scmGit(branches: [[name: 'refs/tags/${params.version}']], extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'RuoYi-Cloud']], userRemoteConfigs: [[url: 'https://gitee.com/y_project/RuoYi-Cloud.git']])
                }
            }
        }

        stage('build package') {
            steps {
                withDockerContainer('maven:3.9.0') {
                    sh "mvn clean"
                    sh "mvn clean package -Dmaven.test.skip=true"
                    sh "echo ${params.deploy_hostname}"
                }
            }
        }

        stage('build image') {
            parallel {
                stage('build ruoyi-gateway') {
                    steps {
                        sh "docker build --build-arg JAR_NAME=ruoyi-gateway -t buxiaomo/ruoyi-gateway:${params.version} ."
                    }
                }
                stage('build ruoyi-auth') {
                    steps {
                        sh "docker build --build-arg JAR_NAME=ruoyi-auth -t buxiaomo/ruoyi-auth:${params.version} ."
                    }
                }
                stage('build ruoyi-modules-system') {
                    steps {
                        echo "在 agent test2 上执行的并行任务 2."
                    }
                }
                stage('build ruoyi-modules-gen') {
                    steps {
                        echo "在 agent test2 上执行的并行任务 2."
                    }
                }
                stage('build ruoyi-modules-job') {
                    steps {
                        echo "在 agent test2 上执行的并行任务 2."
                    }
                }
                stage('build ruoyi-modules-file') {
                    steps {
                        echo "在 agent test2 上执行的并行任务 2."
                    }
                }
                stage('build ruoyi-visual-monitor') {
                    steps {
                        echo "在 agent test2 上执行的并行任务 2."
                    }
                }
            }
        }
    }
}
