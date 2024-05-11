If you are hosting your Rails app on ECS Fargate and want to connect to the Rails console or launch a bash session, you need to use AWS cli like so :

```bash
aws ecs execute-command --region eu-west-3 --cluster CLUSTER_ARN --task TASK_ARN --container CONTAINER_NAME --command 'bundle exec rails console' --interactive
```

This gem helps to get the correct cluster arn and task id so that you don't have to get them yourself.

```bash
ecs console
ecs bash
```

# Installation

Install [AWS cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

Install [AWS Session Manager plugin](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html)

Install gem

```ruby
gem install 'ecs-rails'
```

# Configuration

## Plain Ruby

Via environment variables:

```
export ENV['AWS_REGION'] = 'us-east-1'
export ENV['AWS_ACCESS_KEY_ID'] = 'your-access-key-id'
export ENV['AWS_SECRET_ACCESS_KEY'] = 'your-secret-access-key'
export ENV['CONTAINER_NAME'] = 'your-container-name'
```

## Rails

```ruby
# config/initializers/ecs-rails.rb
EcsRails.aws_region = 'us-east-1'
EcsRails.aws_access_key_id = ENV['AWS_ACCESS_KEY_ID']
EcsRails.aws_secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
EcsRails.container_name = 'webapp'
```

# Usage

Connect to Rails console on a running Task.

```ruby
ecs console

Select a cluster:
1) cluster-prod
2) cluster-staging
Choose 1-2 [1]:

Select a service:
1) app
2) worker
Choose 1-2 [1]:

irb(main)>
```

You can specify cluster name via -c option by giving a string included in cluster arn.
You can specify service name via -s option by giving a string included in service arn.

```ruby
# with cluster name: webapp-cluster-prod-e950a13
# with service name: webapp-app-prod-7c7cad7
ecs console -c prod -s app
irb(main)>
```
