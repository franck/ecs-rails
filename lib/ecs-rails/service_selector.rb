module EcsRails
  class ServiceSelector

    def initialize(client, cluster)
      @client = client
      @cluster = cluster
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
        puts("Connecting to service '#{service}':")
        return service
      end

      puts('Select a service:')

      services.each_with_index do |service, index|
        puts("#{index + 1}. #{service.split('/').last}")
      end

      selection = $stdin.gets.chomp.to_i
      unless selection.between?(1, services.size)
        puts('Invalid selection.')
        exit
      end

      services[selection - 1]
    end


    private

      attr_reader :client, :cluster
  end
end
