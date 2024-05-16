require 'yaml'
require 'singleton'

module EcsRails
  class EcsRailsConfiguration
    include Singleton

    attr_accessor :aws_region
    attr_accessor :aws_access_key_id
    attr_accessor :aws_secret_access_key 
    attr_accessor :container_name

    def self.delegated
      public_instance_methods - Singleton.instance_methods
    end

    def initialize
      @aws_region = 'us-east-1'
      @aws_access_key_id = nil
      @aws_secret_access_key = nil
      @container_name = 'webapp'
    end

    def load_settings(file_path=nil)
      file_path ||= default_settings_file_path
      yaml = YAML.load_file(file_path)
      yaml_settings = yaml['settings']
      yaml_settings.each do |key, value|
        send("#{key}=", value)
      end
    end

    def aws_region
      @aws_region
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

    private

      def default_settings_file_path
        File.join(Dir.pwd, 'config', 'ecs-rails.yml')
      end

  end
end
