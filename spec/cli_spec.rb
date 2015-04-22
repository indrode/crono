require 'spec_helper'
require 'crono/cli'

describe Crono::CLI do
  let(:cli) { Crono::CLI.instance }

  describe '#run' do
    it 'should initialize rails with #load_rails and start working loop' do
      expect(cli).to receive(:load_rails)
      expect(cli).to receive(:start_working_loop)
      expect(cli).to receive(:parse_options)
      expect(cli).to receive(:write_pid)
      expect(Crono::Cronotab).to receive(:process)
      cli.run
    end
  end

  describe '#parse_options' do
    it 'should set cronotab' do
      cli.send(:parse_options, ['--cronotab', '/tmp/cronotab.rb'])
      expect(cli.config.cronotab).to be_eql '/tmp/cronotab.rb'
    end

    it 'should set logfile' do
      cli.send(:parse_options, ['--logfile', 'log/crono.log'])
      expect(cli.config.logfile).to be_eql 'log/crono.log'
    end

    it 'should set pidfile' do
      cli.send(:parse_options, ['--pidfile', 'tmp/pids/crono.0.log'])
      expect(cli.config.pidfile).to be_eql 'tmp/pids/crono.0.log'
    end

    it 'should set daemonize' do
      cli.send(:parse_options, ['--daemonize'])
      expect(cli.config.daemonize).to be true
    end

    it 'should set environment' do
      cli.send(:parse_options, ['--environment', 'production'])
      expect(cli.config.environment).to be_eql('production')
    end
  end
end
