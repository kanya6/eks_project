pipeline {
    agent any
    parameters { 
        choice(name: 'action', choices: ['apply', 'destroy', 'plan'], description: 'Choose whether to apply or destroy the Terraform infrastructure') 
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
                        sh 'terraform init'
                    }
                }
            }
        }
        // stage('Formatting Terraform Code'){
        //     steps{
        //         script{
        //             dir('EKS'){
        //                 sh 'terraform fmt'
        //             }
        //         }
        //     }
        // }
        // stage('Validating Terraform'){
        //     steps{
        //         script{
        //             dir('EKS'){
        //                 sh 'terraform validate'
        //             }
        //         }
        //     }
        // }
        // stage('Previewing the Infra using Terraform'){
        //     steps{
        //         script{
        //             dir('EKS'){
        //                 sh 'terraform plan'
        //             }
        //             input(message: "Are you sure to proceed?", ok: "Proceed")
        //         }
        //     }
        // }
        stage('Creating/Destroying an EKS Cluster') {
            steps {
                script {
                    dir('EKS') {
                        if (params.action == 'plan') {
                            sh 'terraform plan'
                        } else {
                            sh "terraform ${params.action} --auto-approve"
                        }
                    }
                }
            }
        }
        // stage('Update Kubeconfig') { 
        //     steps { 
        //         withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS-credentials']]) { 
        //             sh ''' aws eks --region us-east-1 update-kubeconfig --name my-eks-cluster '''
        //             sh 'kubectl apply -f deployment.yaml'
        //             sh 'kubectl apply -f service.yaml' 
        //             } 
        //         } 
        //     }
        stage('Deploying Nginx Application') {
            steps{
                script{
                    withCredentials([[ $class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS-credentials' 
                    ]]) {
                    dir('EKS/Configurationfiles') {
                        sh 'aws eks --region us-east-1 update-kubeconfig --name my-eks-cluster'
                        sh 'kubectl apply -f deployment.yaml'
                        sh 'kubectl apply -f service.yaml'
                    }
                }
            }
        }
    }
}