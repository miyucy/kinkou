require 'singleton'
require_relative 'configuration'
require_relative 'api'

module Kintou
  class Tracker
    include Singleton

    def self.bind
      instance.bind
    end

    def bind
      tracker = self
      ::RSpec.configure do |config|
        config.around(:all) do |example|
          tracker.around_all example
        end

        config.after(:suite) do
          tracker.after_suite
        end
      end
    end

    def around_all(example)
      f = File.expand_path example.file_path
      t = Time.now
      example.run
    ensure
      config.execution_times[f] += Time.now - t
    end

    def after_suite
      API.results config
    end

    def config
      Configuration.instance
    end
  end
end
