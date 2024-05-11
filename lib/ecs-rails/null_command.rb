module EcsRails
  class NullCommand

    def call
      puts 'You must specify a command (console, bash, logs, …)'
      exit 1
    end

  end
end
