FROM public.ecr.aws/lambda/python:3.8

COPY addition_program.py .

CMD ["addition_program.lambda_handler"]