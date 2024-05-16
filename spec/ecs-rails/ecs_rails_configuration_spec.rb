require 'spec_helper'

describe EcsRails::EcsRailsConfiguration do


  describe '#default' do

    it 'sets region to us-east-1' do
      expect(EcsRails.aws_region).to eq('us-east-1')
    end
  end

  describe 'set aws region' do
    describe 'directly' do
      it 'sets region to us-west-2' do
        EcsRails.aws_region = 'us-west-2'
        expect(EcsRails.aws_region).to eq('us-west-2')
      end
    end
    describe 'via configuration file' do
      it 'sets region to us-west-2' do
        EcsRails.load_settings('spec/fixtures/ecs-rails.yml')
        expect(EcsRails.aws_region).to eq('us-west-2')
      end
    end
  end


end
