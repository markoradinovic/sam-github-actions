FROM amazonlinux:latest

LABEL "com.github.actions.name"="AWS SAM Lambda Deployment"
LABEL "com.github.actions.description"="Deploying Lambda via AWS SAM cli"
LABEL "com.github.actions.icon"="layers"
LABEL "com.github.actions.color"="gray-dark"

LABEL "repository"="https://github.com/chriscoffee/sam-github-actions"
LABEL "homepage"="https://github.com/chriscoffee"
LABEL "maintainer"="Chris Mills <millscj01@gmail.com>"
LABEL "version"="0.0.1"

RUN yum upgrade -y \
	&& yum install -y \
		unzip \
		groff \
		jq \
		python3 \
		python3-devel \
		python3-pip \
	&& pip3 install \
		awscli \
		aws-sam-cli \
	&& mkdir -p /root/.aws \
	&& { \
		echo '[default]'; \
		echo 'output = json'; \
		echo 'region = $AWS_DEFAULT_REGION'; \
		echo 'aws_access_key_id = $AMAZON_ACCESS_KEY_ID'; \
		echo 'aws_secret_access_key = $AMAZON_SECRET_ACCESS_KEY'; \
	} > /root/.aws/config

COPY "entrypoint.sh" "/entrypoint.sh"
ENTRYPOINT ["entrypoint.sh"]
