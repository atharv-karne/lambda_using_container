pipeline
{
    agent any
    stages
    {
        stage('Create ECR Repo')
        {
            steps
            {
                script
                {
                    def repoName = "addition-image"
                    withCredentials([aws(credentialsId:'AWS-Cred', region:'ap-south-1')])
                    {
                        sh 'aws ecr create-repository --repository-name ${repoName} --region ap-south-1 || true'
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
                sh 'docker build -t addition-image .'
            }
            }
        }

        stage('Push image to ECR')
        {
            steps
            {
            script
            {
            def repoName = 'addition-image'
            def region = 'ap-south-1'
            def accountId = '730335267178'

            withCredentials([aws(credentialsId:'AWS-Cred', region:'ap-south-1')])
            {
                sh """ 
                aws ecr get-login-password --region ${region} | docker login --username AWS -password-stdin ${accountId}.dkr.ecr.${region}.amazonaws.com
                """
                sh "docker tag addition-image:latest ${accountId}.dkr.ecr.${region}.amazonaws.com/${repoName}:latest"

                sh "docker push ${accountId}.dkr.ecr.${region}.amazonaws.com/${repoName}:latest"
            }
            }
            }
        }
    }
}