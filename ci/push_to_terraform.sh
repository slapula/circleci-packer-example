#!/bin/bash
NEW_AMI=$(cat -v manifest.json | jq '.["builds"][-1]["artifact_id"]' | cut -d ':' -f 2 | rev | cut -c 2- | rev)

set -x

git clone git@github.com:slapula/terraform-circleci-example.git

cd terraform-circleci-example

sed -i.bak "s/\basg_instance_ami.*\b/asg_instance_ami = \"${NEW_AMI}/g" stacks/staging/terraform.tfvars 

if ! git diff --quiet; then
  git add --all
  git commit -m "images: Updated by CircleCI [ci skip]"
  git push origin HEAD:${CIRCLE_BRANCH}
else
  echo "No changes committed."
fi
