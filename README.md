# AWS SAM Action

Performs AWS Serverless Application Model CLI commands in GitHub Actions

---

## Usage

Create `.github/workflow/sam.yaml` file with the required actions similar to the example
given in the workflow section

By default you'll need to set the following secrets in `Settings->Secrets`

```
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_DEFAULT_REGION
```

## Example workflow

This workflow packages and deploys the SAM

```
on:
  push:
    branches:
      - master
name: Publish SAM to AWS
jobs:
  deploy:
    name:  Package
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: Package
      uses: chriscoffee/sam-github-actions@master
      env:
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        AWS_DEFAULT_REGION: eu-west-1
        S3_BUCKET: ${{ secrets.S3_BUCKET }}
      with:
        args: package --template-file template.yaml --s3-bucket ${{ secrets.S3_BUCKET }} --output-template-file packaged.yaml
    - name: Deploy
      uses: chriscoffee/sam-github-actions@master
      env:
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        AWS_DEFAULT_REGION: eu-west-1
        STACK_NAME: ${{ secrets.STACK_NAME }}
      with:
        args: deploy --template-file packaged.yaml --stack-name ${{ secrets.STACK_NAME }} --capabilities CAPABILITY_IAM
