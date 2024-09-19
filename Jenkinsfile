pipeline
{
    agent any
    
    environment
    {
        repoName = "addition-image"
        region = "ap-south-1"
        accountId = "730335267178"
        ECR_URI = "${accountId}.dkr.ecr.${region}.amazonaws.com/${repoName}:latest"

    }
    stages
    {
        stage('Create ECR Repo')
        {
            steps
            {
                script
                {
                    withCredentials([aws(credentialsId:'AWS-Cred', region:'ap-south-1')])
                    {
                        sh "aws ecr create-repository --repository-name ${repoName} --region ap-south-1 || true"
                    }
                }
            }
            
        }
        stage('Build Docker image')
        {
            steps
            {
            script
            {
                sh "docker build -t ${repoName} ."
            }
            }
        }

        stage('Push image to ECR')
        {
            steps
            {
            script
            {
            withCredentials([aws(credentialsId:'AWS-Cred', region:'ap-south-1')])
            {
                sh """ 
                aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${accountId}.dkr.ecr.${region}.amazonaws.com
                """
                sh "docker tag addition-image:latest ${accountId}.dkr.ecr.${region}.amazonaws.com/${repoName}:latest"

                sh "docker push ${accountId}.dkr.ecr.${region}.amazonaws.com/${repoName}:latest"
            }
            }
            }
        }

        stage('Terraform init')
        {
            steps
            {
                script
                {
                    sh "terraform init"
                }
            }
        }
        stage('Terraform apply')
        {
            steps
            {

                script
                {
                    withCredentials([aws(credentialsId:'AWS-Cred', region:'ap-south-1')])
                    {
                    sh "terraform apply -auto-approve"
                    }
                }
            }
        }
    }
}