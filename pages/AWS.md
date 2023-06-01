---
title: AWS
layout: default
---

# AWS

## EKS

### Generate kubectl config for AWS EKS
```shell
aws eks --region eu-central-1 update-kubeconfig --name EKS_NAME --kubeconfig ~/.kube/kubeconfig-eks
```

## ECS

### Connect to container in ECS

```shell
AWS_PROFILE=YOUR_PROFILE aws ecs execute-command \
--cluster YOUR_CLUSTER --task YOUR_TASK \
--command "/bin/sh" \
--interactive
```

ℹ️ Needs `enableExecuteCommand: true` in AppService (FargateService in ECS).

### Manually update container image in ECS

```shell
awsownerprofile aws ecs describe-task-definition --task-definition TASK_DEFINITION_ID --query taskDefinition > task-definition.json

# auf der task-definition.json
jq '.taskDefinition | del(.taskDefinitionArn) | del(.revision) | del(.status) | del(.requiresAttributes) | del(.compatibilities)'

awsownerprofile aws ecs register-task-definition --family TASK_DEFINITION_ID --cli-input-json file://task-definition.json --query taskDefinition.revision

awsownerprofile aws ecs update-service --service APP_SERVICE_ID --cluster ECS_CLUSTER_ID --task-definition TASK_DEFINITION_ID:REVISION
```

Vorteil:
- Deployment in 1 Minute (noch unklar, ab wann der Container erreichbar ist)

Nachteil:
- Cloud Formation Drift (andere Version als im letzten Cloud Formation template)


## EC2

### Connect to EC2 instance

```shell
AWS_PROFILE=YOUR_PROFILE aws ssm start-session --target YOUR_INSTANCE_ID
```

### Port Forwarding for EC2

```shell
AWS_PROFILE=YOUR_PROFILE aws ssm start-session \
--target YOUR_INSTANCE_IDE \
--document-name AWS-StartPortForwardingSession \
--parameters '{"portNumber":["8000"],"localPortNumber":["8000"]}'
```
