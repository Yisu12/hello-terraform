pipeline {
    agent any

    stages {
        stage('Deploy') {
            steps {
                withAWS(credentials: 'aws-credentials', region: 'eu-west-1') {
                    sshagent(['ssh-amazon']) {
                        sh 'terraform init'
                        sh 'terraform apply -auto-approve'
                    }  
                }
            }
        }
    }
}

