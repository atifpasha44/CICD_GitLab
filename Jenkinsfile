pipeline {
    agent any
    
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
    
    stages {
            stage('checkout') {
              steps {
                 script{
                        dir("terraform")
                        {
                            git "https://github.com/atifpasha44/CICD_GitLab.git"
                        }
                    }
                }
            }

        stage('validate') {
            steps {
                script {
                    sh 'terraform --version'
                    sh 'terraform init -backend-config="tfstate.config"'
                    sh 'terraform validate'
                }
            }
        }
        
        stage('plan') {
            steps {
                script {
                    sh 'terraform plan -out="planfile"'
                }
                post {
                    success {
                        archiveArtifacts 'planfile'
                    }
                }
            }
        }
        
        stage('apply') {
            when {
                expression {
                    currentBuild.result == null || currentBuild.result == 'SUCCESS'
                }
            }
            steps {
                input 'Proceed with Terraform apply?'
                script {
                    sh 'terraform apply -input=false planfile'
                }
            }
        }
        
        stage('destroy') {
            when {
                expression {
                    currentBuild.result == null || currentBuild.result == 'SUCCESS'
                }
            }
            steps {
                input 'Proceed with Terraform destroy?'
                script {
                    sh 'terraform destroy --auto-approve'
                }
            }
        }
    }
}
