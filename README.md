```
on: push
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
        S3_BUCKET: $S3_BUCKET
      with:
        args: sam package --template-file template.yaml --s3-bucket ${{ secrets.S3_BUCKET }} --output-template-file packaged.yaml
    - name: Deploy
      uses: chriscoffee/sam-github-actions@master
      env:
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        STACK_NAME: $STACK_NAME
      with:
        args: sam deploy --template-file packaged.yaml --stack-name $STACK_NAME --capabilities CAPABILITY_IAM
    - name: Upload Artifacts
      uses: actions/upload-artifact@master
      with:
        name: packaged.yaml
        path: packaged.yaml
```
