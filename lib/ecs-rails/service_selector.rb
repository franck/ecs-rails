module EcsRails
  class ServiceSelector

    def initialize(client, cluster, service_filter = nil)
      @client = client
      @cluster = cluster
      @service_filter = service_filter
    end

    def call
      puts('Fetching services...')
      services = client.list_services(cluster: cluster).service_arns

      if services.empty?
        puts('No services found in the cluster.')
        exit
      end

      if services.size == 1
        service = services.first
        connecting_to_service(service)
        return service
      end

      if service_filter
        filtered_services = services.select { |service| service.include?(service_filter) }

        if filtered_services.empty?
          puts("No service found with this keyword '#{service_filter}'.")
          exit
        end
        
        connecting_to_service(filtered_services.first)
        return filtered_services.first
      else
        ask_for_service(services)
      end
    end


    private

      attr_reader :client, :cluster, :service_filter

      def connecting_to_service(service_name)
        puts('')
        puts("Connecting to service '#{service_name}':")
        puts('')
        puts('=' * 50)
      end

      def ask_for_service(services)
        prompt = TTY::Prompt.new
        choices = services.map { |service| service.split('/').last }
        choice = prompt.enum_select("Select a service:", choices)
        services.grep(Regexp.new(choice)).first
      end
  end
end
