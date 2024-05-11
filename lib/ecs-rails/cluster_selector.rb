module EcsRails
  class ClusterSelector
    def initialize(client, filter = nil)
      @client = client
      @filter = filter
    end

    def cluster
      clusters.find { |cluster| cluster.cluster_name == cluster_name }
    end

    def call
      puts('Fetching clusters...')
      clusters = client.list_clusters.cluster_arns

      if clusters.empty?
        puts('No clusters found.')
        exit
      end

      puts('=' * 50)
      puts('Clusters found:')
      clusters.each_with_index do |cluster, index|
        puts("#{index + 1}. #{cluster.split('/').last}")
      end
      puts('=' * 50)


      if filter
        filtered_clusters = clusters.select { |cluster| cluster.include?(filter) }
        if filtered_clusters.empty?
          puts("No clusters found with the filter '#{filter}'.")
          exit
        else
          puts('')
          puts("Connecting to cluster '#{filtered_clusters.first}':")
          puts('')
          puts('=' * 50)
        end
        filtered_clusters.first
      else
        puts('Select a cluster:')
        clusters.each_with_index do |cluster, index|
          puts("#{index + 1}. #{cluster.split('/').last}")
        end

        selection = $stdin.gets.chomp.to_i
        unless selection.between?(1, clusters.size)
          puts('Invalid selection.')
          exit
        end

        clusters[selection - 1]
      end
    end

    private

      attr_reader :client, :filter

  end
end
