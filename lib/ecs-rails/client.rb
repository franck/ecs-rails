module EcsRails
  class Client

    def client
      Aws::ECS::Client.new(aws_credentials)
    end

    private

      def aws_credentials
        @aws_credentials ||= {
          region: ENV['AWS_REGION'],
          access_key_id: ENV['AWS_ACCESS_KEY_ID'],
          secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
        }
      end

  end
end

