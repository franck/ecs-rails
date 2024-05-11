require 'spec_helper'

describe 'Ecs binary' do

  context 'without arguments' do
    it 'should run ecs help' do
      output = EcsRails::CommandExecutor.call('', {})
      expect(output).to include('You must specify a command')
    end
  end

  context 'with console command argument' do
    it 'calls the command factory with correct command keyword' do
      command_factory_instance = double('command_factory_instance')

      expect(EcsRails::CommandFactory).to receive(:new).with('console', {}).and_return(command_factory_instance)

      command_instance = double('command_instance')

      expect(command_factory_instance).to receive(:command).and_return(command_instance)
      expect(command_instance).to receive(:call)

      EcsRails::CommandExecutor.call('bash', {})
    end
  end
end
