module EcsRails
  class Command

    def initialize(cluster_name = nil)
      @cluster_name = cluster_name
    end

    def call
      raise NotImplementedError
    end

    private

      attr_reader :cluster_name

      def client
        client = EcsRails::Client.new.client
      end

      def container_name
        EcsRails.container_name
      end

      def region
        EcsRails.aws_region
      end

      def selected_cluster
        @selected_cluster ||= EcsRails::ClusterSelector.new(client, cluster_name).call
      end

      def selected_service
        puts("Selected cluster: #{selected_cluster}")
        @selected_service ||= EcsRails::ServiceSelector.new(client, selected_cluster).call
      end

      def task_id
        puts("Selected service: #{selected_service}")
        @task_id ||= EcsRails::TaskSelector.new(client, selected_cluster, selected_service).call
      end
  end
end

