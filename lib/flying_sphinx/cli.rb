require 'forwardable'

class FlyingSphinx::CLI
  extend Forwardable

  COMMANDS = {
    'configure' => [:configure],
    'index'     => [:index],
    'setup'     => [:configure, :index],
    'start'     => [:start],
    'stop'      => [:stop],
    'restart'   => [:restart],
    'rebuild'   => [:rebuild]
  }

  def_delegators :controller, :start, :stop, :restart

  def initialize(command, arguments = [])
    @command, @arguments = command, arguments
  end

  def run
    methods = COMMANDS[@command]
    raise "Unknown command #{@command}" if methods.nil?

    methods.all? do |method|
      FlyingSphinx.logger.info "Executing Action: #{method}"
      result = send method
      FlyingSphinx.logger.info "Action Finished: #{method}"

      result
    end
  end

  private

  def configuration
    @configuration ||= FlyingSphinx::Configuration.new
  end

  def configure
    if @arguments.empty?
      load_rails

      controller.configure
    else
      controller.configure File.read(@arguments.first)
    end

    true
  end

  def controller
    @controller ||= FlyingSphinx::Controller.new configuration.api
  end

  def index
    indices = @arguments + [{:verbose => true}]
    controller.index *indices
  end

  def load_rails
    return unless ENV['RAILS_ENV']

    require File.expand_path('config/boot', Dir.pwd)
    require File.expand_path('config/application', Dir.pwd)
    Rails.application.require_environment!

    require 'flying_sphinx/delayed_delta'
  end

  def rebuild
    load_rails

    controller.rebuild
  end
end