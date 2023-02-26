pipeline {
    agent { 
        label "swarm"
    }

    environment {
        REPOSITORY_URL = "https://github.com/buxiaomo/RuoYi.git"

        // REGISTRY_AUTH = "qingcloud"
        REGISTRY_USER = "buxiaomo"
        REGISTRY_HOST = "172.16.115.11:5000"
    }

    parameters{
        string(
            description: "Version of RuoYi-Cloud ?",
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

        stage('maven package') {
            steps {
                dir('RuoYi-Cloud') {
                    retry(3) {
                        withDockerContainer('maven:3.9.0') {
                            sh "mvn clean package -Dmaven.test.skip=true"
                        }
                    }
                }
            }
        }

        stage('build image') {
            parallel {
                stage('build ruoyi-gateway') {
                    steps {
                        sh label: 'Build', script: "docker build -t 172.16.115.11:5000/buxiaomo/ruoyi-gateway:${params.version} -f gateway.Dockerfile ."
                        sh label: 'Push', script: "docker push 172.16.115.11:5000/buxiaomo/ruoyi-gateway:${params.version}"
                    }
                }
                stage('build ruoyi-auth') {
                    steps {
                        sh label: 'Build', script: "docker build -t 172.16.115.11:5000/buxiaomo/ruoyi-auth:${params.version} -f auth.Dockerfile ."
                        sh label: 'Push', script: "docker push 172.16.115.11:5000/buxiaomo/ruoyi-auth:${params.version}"
                    }
                }
                stage('build ruoyi-modules-system') {
                    steps {
                        sh label: 'Build', script: "docker build -t 172.16.115.11:5000/buxiaomo/ruoyi-modules-system:${params.version} -f modules-system.Dockerfile ."
                        sh label: 'Push', script: "docker push 172.16.115.11:5000/buxiaomo/ruoyi-modules-system:${params.version}"
                    }
                }
                stage('build ruoyi-modules-gen') {
                    steps {
                        sh label: 'Build', script: "docker build -t 172.16.115.11:5000/buxiaomo/ruoyi-modules-gen:${params.version} -f modules-gen.Dockerfile ."
                        sh label: 'Push', script: "docker push 172.16.115.11:5000/buxiaomo/ruoyi-modules-gen:${params.version}"
                    }
                }
                stage('build ruoyi-modules-job') {
                    steps {
                        sh label: 'Build', script: "docker build -t 172.16.115.11:5000/buxiaomo/ruoyi-modules-job:${params.version} -f modules-job.Dockerfile ."
                        sh label: 'Push', script: "docker push 172.16.115.11:5000/buxiaomo/ruoyi-modules-job:${params.version}"
                    }
                }
                stage('build ruoyi-modules-file') {
                    steps {
                        sh label: 'Build', script: "docker build -t 172.16.115.11:5000/buxiaomo/ruoyi-modules-file:${params.version} -f modules-file.Dockerfile ."
                        sh label: 'Push', script: "docker push 172.16.115.11:5000/buxiaomo/ruoyi-modules-file:${params.version}"
                    }
                }
                stage('build ruoyi-visual-monitor') {
                    steps {
                        sh label: 'Build', script: "docker build -t 172.16.115.11:5000/buxiaomo/ruoyi-visual-monitor:${params.version} -f visual-monitor.Dockerfile ."
                        sh label: 'Push', script: "docker push 172.16.115.11:5000/buxiaomo/ruoyi-visual-monitor:${params.version}"
                    }
                }
                stage('build ruoyi-vue') {
                    steps {
                        sh label: 'Build', script: "docker build -t 172.16.115.11:5000/buxiaomo/ruoyi-ui:${params.version} -f ruoyi-ui.Dockerfile ."
                        sh label: 'Push', script: "docker push 172.16.115.11:5000/buxiaomo/ruoyi-ui:${params.version}"
                    }
                }
            }
        }

        stage('deploy service') {
            steps {
                withKubeConfig(caCertificate: '', clusterName: 'kubernetes', contextName: 'default', credentialsId: 'k8s', namespace: 'ruoyi', restrictKubeConfigAccess: false, serverUrl: 'https://172.16.115.11:6443') {
                    sh 'helm upgrade -i ruoyi -f ./values.yaml ruoyi --create-namespace --namespace ruoyi'
                }
            }
        }
    }
}
