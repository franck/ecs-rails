module EcsRails
  class CommandExecutor

    def self.call(command_keyword, options = {})
      CommandFactory.new(command_keyword, options).command.call
    end

  end
end
