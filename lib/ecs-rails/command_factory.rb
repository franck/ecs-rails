module EcsRails
  class CommandFactory

    def initialize(command_keyword, options = {})
      @command_keyword = command_keyword
      @cluster_name = options[:cluster]
      @service_name = options[:service]
    end

    def command
      case command_keyword
      when 'console'
        EcsRails::Console.new(cluster_name, service_name)
      when 'bash'
        EcsRails::Bash.new(cluster_name, service_name)
      else
        EcsRails::NullCommand.new
      end
    end

    private

      attr_reader :command_keyword, :cluster_name, :service_name

  end
end
