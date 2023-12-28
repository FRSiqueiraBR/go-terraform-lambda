provider "aws" {
  region = "sa-east-1"
}

resource "aws_lambda_function" "golang_example_function" {
  filename         = "./lambda.zip"                       # caminho para o código da sua função
  function_name    = "golang-example_function"          # nome da sua função Lambda
  role             = aws_iam_role.lambda_role.arn       # ARN da role IAM associada à função
  handler          = "main.handler"                     # o arquivo e a função que será executada (ex: nome_do_arquivo.função)
  runtime          = "go1.x"                            # substitua pelo runtime adequado à sua função
  memory_size      = 128                                # tamanho da memória alocada à função
  timeout          = 30                                 # tempo limite de execução da função em segundos

  source_code_hash = filebase64sha256("lambda.zip")
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# Anexar uma política básica ao papel IAM da função Lambda
resource "aws_iam_policy_attachment" "lambda_policy_attachment" {
  name       = "lambda_policy_attachment"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}