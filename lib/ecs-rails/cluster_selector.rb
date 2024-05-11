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

      if filter
        filtered_clusters = clusters.select { |cluster| cluster.include?(filter) }

        if filtered_clusters.empty?
          puts("No clusters found with this keyword '#{filter}'.")
          exit
        end

        connecting_to_cluster(filtered_clusters.first)
        return filtered_clusters.first
      else
        ask_for_cluster(clusters)
      end
    end

    private

      attr_reader :client, :filter

      def connecting_to_cluster(cluster_name)
        puts('')
        puts("Connecting to cluster '#{cluster_name}':")
        puts('')
        puts('=' * 50)
      end

      def ask_for_cluster(clusters)
        prompt = TTY::Prompt.new
        choices = clusters.map { |cluster| cluster.split('/').last }
        choice = prompt.enum_select("Select a cluster:", choices)
        clusters.grep(Regexp.new(choice)).first
      end

  end
end
