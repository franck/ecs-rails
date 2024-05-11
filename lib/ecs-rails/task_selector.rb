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
            ask_for_task(tasks_for_deployment)
          end
        end
      end
    end

    private

      attr_reader :client, :cluster_name, :service_name

      def ask_for_task(tasks)
        prompt = TTY::Prompt.new
        choices = tasks.map { |task| task.split('/').last }
        choice = prompt.enum_select("Select a task:", choices)
        tasks.grep(Regexp.new(choice)).first
      end
  end
end
