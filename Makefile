CODE := 000000

all: get-token
	@aws configure set aws_access_key_id $(shell cat session.json | jq -r .Credentials.AccessKeyId) --profile mfa
	@aws configure set aws_secret_access_key $(shell cat session.json | jq -r .Credentials.SecretAccessKey) --profile mfa
	@aws configure set aws_session_token $(shell cat session.json | jq -r .Credentials.SessionToken) --profile mfa

get-token:
	@aws sts get-session-token --serial-number arn:aws:iam::404672225309:mfa/pauwels --token-code ${CODE} --profile user --output json > session.json
