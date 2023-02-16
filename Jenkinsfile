pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'docker-compose build'
                sh 'git tag 1.0.${BUILD_NUMBER}'
                sh 'docker tag ghcr.io/yisu12/hello-2048:latest ghcr.io/yisu12/hello-2048:1.0.${BUILD_NUMBER}'
                sshagent(['git2']) {
                    sh 'git push --tags'
                }
            }
        }
        stage('Package') {
            steps {
                withCredentials([string(credentialsId: 'github-token', variable: 'CR_PAT')]) {
                    sh 'echo $CR_PAT | docker login ghcr.io -u yisu12 --password-stdin'
                    sh "docker push ghcr.io/yisu12/hello-2048:1.0.${BUILD_NUMBER}"
                }
            }
        }

        stage('Create') {
            steps {
                withAWS(credentials: 'aws-credentials', region: 'eu-west-1') {
                    sshagent(['ssh-amazon']) {
                        sh 'terraform init'
                        sh 'terraform apply -auto-approve'
                    }  
                }
            }
        }
        stage('Install') {
              steps{
                    withAWS(credentials: 'aws-credentials', region: 'eu-west-1') {
                         sshagent(['ssh-amazon']) {
                                 sh 'ansible-playbook -i aws_ec2.yml ec2.yml'
                         }
                    }

              }
        }
    }
}


