def ACCOUNT_ID = ""
def ECR_REPO = ""

pipeline {

    agent any

    environment {
        TF_VAR_aws_region = "${params.AWS_REGION}"
        AWS_DEFAULT_REGION = "${params.AWS_REGION}"
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    parameters {

        string(
            name: 'AWS_REGION',
            defaultValue: 'ap-south-1',
            description: 'AWS Region'
        )

        string(
            name: 'IMAGE_NAME',
            defaultValue: 'demo-app',
            description: 'Docker Image Name'
        )

        string(
            name: 'CLUSTER_NAME',
            defaultValue: 'demo-eks-cluster',
            description: 'EKS Cluster Name'
        )

        booleanParam(
            name: 'DESTROY_INFRA',
            defaultValue: false,
            description: 'Destroy Terraform Infrastructure'
        )
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

                        ACCOUNT_ID = sh(
                            script: 'aws sts get-caller-identity --query Account --output text',
                            returnStdout: true
                        ).trim()

                        ECR_REPO = "${ACCOUNT_ID}.dkr.ecr.${params.AWS_REGION}.amazonaws.com/${params.IMAGE_NAME}"

                        echo "AWS Account ID: ${ACCOUNT_ID}"
                        echo "ECR Repository: ${ECR_REPO}"
                        echo "Image Tag: ${IMAGE_TAG}"
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

            when {
                expression { !params.DESTROY_INFRA }
            }

            steps {

                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {

                    dir('terraform') {

                        sh '''
                        terraform apply -auto-approve
                        '''
                    }
                }
            }
        }

        stage('Terraform Destroy') {

            when {
                expression { params.DESTROY_INFRA }
            }

            steps {

                input message: 'Confirm Infrastructure Destruction'

                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {

                    script {

                        sh '''
                        helm uninstall demo-app || true
                        kubectl delete ingress --all || true
                        '''

                        dir('terraform') {

                            sh '''
                            terraform destroy -auto-approve
                            '''
                        }
                    }
                }
            }
        }

        stage('Docker Build') {

            when {
                expression { !params.DESTROY_INFRA }
            }

            steps {

                dir('app') {

                    sh """
                    docker build -t ${params.IMAGE_NAME}:${IMAGE_TAG} .
                    """
                }
            }
        }

        stage('ECR Login') {

            when {
                expression { !params.DESTROY_INFRA }
            }

            steps {

                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {

                    sh """
                    aws ecr get-login-password --region ${params.AWS_REGION} | \
                    docker login \
                    --username AWS \
                    --password-stdin ${ACCOUNT_ID}.dkr.ecr.${params.AWS_REGION}.amazonaws.com
                    """
                }
            }
        }

        stage('Docker Tag') {

            when {
                expression { !params.DESTROY_INFRA }
            }

            steps {

                sh """
                docker tag ${params.IMAGE_NAME}:${IMAGE_TAG} ${ECR_REPO}:${IMAGE_TAG}
                """
            }
        }

        stage('Docker Push') {

            when {
                expression { !params.DESTROY_INFRA }
            }

            steps {

                sh """
                docker push ${ECR_REPO}:${IMAGE_TAG}
                """
            }
        }

        stage('Configure Kubeconfig') {

            when {
                expression { !params.DESTROY_INFRA }
            }

            steps {

                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {

                    sh """
                    aws eks update-kubeconfig \
                    --region ${params.AWS_REGION} \
                    --name ${params.CLUSTER_NAME}
                    """
                }
            }
        }

        stage('Install NGINX Ingress Controller') {

            when {
                expression { !params.DESTROY_INFRA }
            }

            steps {

                sh '''
                kubectl apply -f \
                https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
                '''
            }
        }

        stage('Wait For Ingress Controller') {

            when {
                expression { !params.DESTROY_INFRA }
            }

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

            when {
                expression { !params.DESTROY_INFRA }
            }

            steps {

                dir('nginx-chart') {

                    sh """
                    helm upgrade --install demo-app . \
                    --set image.repository=${ECR_REPO} \
                    --set image.tag=${IMAGE_TAG}
                    """
                }
            }
        }

        stage('Verify Deployment') {

            when {
                expression { !params.DESTROY_INFRA }
            }

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

            script {

                if (params.DESTROY_INFRA) {

                    echo 'Infrastructure destroyed successfully!'

                } else {

                    echo 'Application deployed successfully!'
                    echo "Deployed Image: ${ECR_REPO}:${IMAGE_TAG}"
                }
            }
        }

        failure {
            echo 'Pipeline failed. Please check Jenkins console output.'
        }
    }
}