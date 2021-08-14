# HCL - Hashicorp configuration language
# linguagem declarativa

resource "aws_s3_bucket" "datalake" {
  #parâmetros de configuração do recurso disponível
  #Usando 3 variaveis criadas no arquivo "variables.tf" para criar o bucket
  bucket = "${var.base_bucket_name}-${var.ambiente}-${var.numero_conta}"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    IES   = "IGTI",
    CURSO = "EDC"
  }


}


resource "aws_s3_bucket_object" "name" {

  bucket = aws_s3_bucket.datalake.id
  key    = "emr-code/pyspark/job_spark_from_tf.py"
  acl    = "private"
  source = "../job_spark.py"
  etag   = filemd5("../job_spark.py")

  tags = {
    IES   = "IGTI",
    CURSO = "EDC"
  }

}

provider "aws" {
  region = "us-east-2"

}