module EcsRails
  class CommandFactory

    def initialize(command_keyword, options = {})
      @command_keyword = command_keyword
      @cluster_name = options[:cluster]
    end

    def command
      case command_keyword
      when 'console'
        EcsRails::Console.new(cluster_name)
      else
        EcsRails::NullCommand.new
      end
    end

    private

      attr_reader :command_keyword, :cluster_name

  end
end
