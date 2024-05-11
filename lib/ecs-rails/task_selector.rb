module EcsRails
  class TaskSelector

    def initialize(client, cluster_name, service_name)
      @client = client
      @cluster_name = cluster_name
      @service_name = service_name
    end

    def call
      puts('Fetching tasks...')
      service_descriptions = client.describe_services(cluster: cluster_name, services: [service_name]).services

      service_descriptions.each do |service|
        service.deployments.each do |deployment|
          task_arns = client.list_tasks(cluster: cluster_name, service_name: service.service_name, desired_status: 'RUNNING').task_arns
          next if task_arns.empty?

          tasks = client.describe_tasks(cluster: cluster_name, tasks: task_arns).tasks

          # Filter tasks by deployment's task definition
          tasks_for_deployment = tasks.select { |task| task.task_definition_arn == deployment.task_definition }

          if tasks_for_deployment.empty?
            puts("      No tasks found for this deployment.")
          elsif tasks_for_deployment.size == 1
            puts("      Task: #{task_arns.first}")
              return task_arns.first
          else
            tasks_for_deployment.each_with_index do |task, index|
              puts("#{index+1}. Task: #{task.task_arn.split('/').last}, Last Status: #{task.last_status}, Desired Status: #{task.desired_status}")
            end
          end

          selection = $stdin.gets.chomp.to_i
          puts("Selected task: #{tasks_for_deployment[selection - 1].task_arn}")

            unless selection.between?(1, task_arns.size)
              puts('Invalid selection.')
              exit
            end

          return task_arns[selection - 1]
        end
      end
    end

    private

      attr_reader :client, :cluster_name, :service_name
  end
end
