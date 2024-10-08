pipeline {
    agent any
    parameters { 
        choice(name: 'action', choices: ['apply', 'destroy'], description: 'Choose whether to apply or destroy the Terraform infrastructure') 
    }
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "us-east-1"
    }
    stages {
        stage('Checkout SCM'){
            steps{
                script{
                    checkout scmGit(branches: [[name: 'develop']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/kanya6/eks_project.git']])
                }
            }
        }
        stage('Initializing Terraform'){
            steps{
                script{
                    dir('EKS'){
                        sh 'terraform init -no-color'
                    }
                }
            }
        }
        stage('Previewing the Infra using Terraform'){
            steps{
                script{
                    dir('EKS'){
                        sh 'terraform plan -no-color'
                    }
                    input(message: "Are you sure to proceed?", ok: "Proceed")
                }
            }
        }
        stage('Creating/Destroying an EKS Cluster') {
            steps {
                script {
                    dir('EKS') {
                        sh "terraform ${params.action} --auto-approve -no-color"
                    }
                }
            }
        }
        // stage('kubectl') {
        //     steps {
        //         script {
        //             dir('EKS') {
        //                 sh "kubectl get ns"
        //             }
        //         }
        //     }
        // }
    }
}