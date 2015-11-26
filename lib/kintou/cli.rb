require 'optparse'
require_relative 'configuration'
require_relative 'api'

module Kintou
  class CLI
    def self.perform
      new(ARGV).perform
    end

    def initialize(args)
      OptionParser.new do |opt|
        opt.on('-n NAME', String) { |v| config.name = v }
        opt.on('-s SESSION', String) { |v| config.session = v }
        opt.on('-t TOTAL', Integer) { |v| config.node_total = v }
        opt.on('-i INDEX', Integer) { |v| config.node_index = v }
        opt.on('-g GLOBS', Array) { |v| config.globs |= v }
        opt.parse(args)
      end
      config.expand_globs
    end

    def perform
      files = API.builds(config)
      puts files.join(' ')
    end

    def config
      Configuration.instance
    end
  end
end
