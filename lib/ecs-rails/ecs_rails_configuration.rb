module EcsRails
  class EcsRailsConfiguration
    attr_accessor :aws_region
    attr_accessor :aws_access_key_id
    attr_accessor :aws_secret_access_key 
    attr_accessor :container_name

    def self.setup
      new.tap do |config|
        yield config if block_given?
      end
    end

    def initialize
      @aws_region = 'us-east-1'
      @aws_access_key_id = nil
      @aws_secret_access_key = nil
      @container_name = nil
    end

    def aws_region=(region)
      @aws_region = region
    end

    def aws_access_key_id=(access_key_id)
      @aws_access_key_id = access_key_id
    end

    def aws_secret_access_key=(secret_access_key)
      @aws_secret_access_key = secret_access_key
    end

    def container_name=(container_name)
      @container_name = container_name
    end

  end
end
