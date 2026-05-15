pipeline {
    agent any

    parameters {
        string(name: 'AWS_REGION', defaultValue: 'ap-south-2', description: 'AWS Region')
        string(name: 'IMAGE_NAME', defaultValue: 'demo-app', description: 'Docker Image Name')
        string(name: 'CLUSTER_NAME', defaultValue: 'demo-eks-cluster', description: 'EKS Cluster Name')
    }

    environment {
        ACCOUNT_ID = ''
        ECR_REPO = ''
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Configure AWS Credentials') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {

                    script {

                        env.ACCOUNT_ID = sh(
                            script: "aws sts get-caller-identity --query Account --output text",
                            returnStdout: true
                        ).trim()

                        env.ECR_REPO = "${env.ACCOUNT_ID}.dkr.ecr.${params.AWS_REGION}.amazonaws.com/${params.IMAGE_NAME}"

                        echo "AWS Account ID: ${env.ACCOUNT_ID}"
                        echo "ECR Repository: ${env.ECR_REPO}"
                    }

                    sh 'aws sts get-caller-identity'
                }
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {

                    dir('terraform') {
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }

        stage('Docker Build') {
            steps {
                dir('app') {
                    sh 'docker build -t ${IMAGE_NAME} .'
                }
            }
        }

        stage('ECR Login') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {

                    sh '''
                    aws ecr get-login-password --region ${AWS_REGION} | \
                    docker login \
                    --username AWS \
                    --password-stdin ${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
                    '''
                }
            }
        }

        stage('Docker Tag') {
            steps {
                sh 'docker tag ${IMAGE_NAME}:latest ${ECR_REPO}:latest'
            }
        }

        stage('Docker Push') {
            steps {
                sh 'docker push ${ECR_REPO}:latest'
            }
        }

        stage('Configure Kubeconfig') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {

                    sh '''
                    aws eks update-kubeconfig \
                    --region ${AWS_REGION} \
                    --name ${CLUSTER_NAME}
                    '''
                }
            }
        }

        stage('Install NGINX Ingress Controller') {
            steps {
                sh '''
                kubectl apply -f \
                https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
                '''
            }
        }

        stage('Wait For Ingress Controller') {
            steps {
                sh '''
                kubectl wait \
                --namespace ingress-nginx \
                --for=condition=ready pod \
                --selector=app.kubernetes.io/component=controller \
                --timeout=300s
                '''
            }
        }

        stage('Helm Deploy') {
            steps {
                dir('nginx-chart') {
                    sh 'helm upgrade --install demo-app .'
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                sh 'kubectl get nodes'
                sh 'kubectl get pods'
                sh 'kubectl get svc'
                sh 'kubectl get ingress'
            }
        }
    }

    post {

        success {
            echo 'Application deployed successfully!'
        }

        failure {
            echo 'Pipeline failed. Please check Jenkins console output.'
        }
    }
}