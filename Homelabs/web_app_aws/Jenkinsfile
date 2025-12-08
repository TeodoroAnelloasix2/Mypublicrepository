pipeline {
    parameters{
        booleanParam(name: 'autoApprove',defaultValue: false, description: 'Automatically run apply after geerating plan?')
    }
    environment {
        AWS_ACCESS_KEY_ID  = credentials('access_key_id')
        AWS_SECRET_ACCESS_KEY = credentials('secret_key')
        AWS_REGION = 'us-east-1'
    }
    agent {label 'master'}
    
    stages{
        stage('get git code'){
            steps {
                checkout([$class: 'GitSCM',
                 branches: [[name: 'main']],
                 doGenerateSubmoduleConfigurations: false,
                 extensions: [],
                  userRemoteConfigs: [[
                url: 'git@github.com:TeodoroAnelloasix2/linkedin_source_code.git',
                credentialsId: 'githubkey'
            ]]
                ])
            }
        }
        stage('Plan'){
            steps{
                sh '''
                cd web-app-infra
                MY_IP=$(curl -s ifconfig.me)/32
                terraform init
                terraform plan -out infra1 -var "my_ip=$MY_IP"
                terraform show -no-color infra1 > tfplan.txt
                '''
            }
        }
        stage('Approved'){
            when{
                not {
                    equals expected: true,actual: params.autoApprove
                }
            }
            steps {
                script {
                    def plan=readFile 'web-app-infra/tfplan.txt'
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                }
            }
        }
        stage('Apply') {
            steps {
                sh "pwd;cd web-app-infra/ ; terraform apply -input=false infra1"
            }
        }
        // stage('Destroy') {
        //     steps {
        //          sh '''
        //          sleep 10
        //          cd web-app-infra
        //          MY_IP=$(curl -s ifconfig.me)/32
        //          terraform destroy -var "my_ip=$MY_IP" -auto-approve
        //          '''
        //     }
        // }

    }
    post{
        always{sleep(2)}
    }
}