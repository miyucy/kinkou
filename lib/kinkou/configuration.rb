require 'singleton'

module Kinkou
  class Configuration
    include Singleton

    attr_accessor :name, :files, :execution_times
    attr_accessor :session, :node_total, :node_index
    attr_accessor :globs, :url

    def initialize
      @name  = ENV['KINKOU_NAME']
      @session = String(ENV['CIRCLE_BUILD_NUM'] || ENV['BUILD_NUMBER'])
      @node_total = Integer(ENV['CIRCLE_NODE_TOTAL'] || ENV['CI_NODE_TOTAL'] || 1)
      @node_index = Integer(ENV['CIRCLE_NODE_INDEX'] || ENV['CI_NODE_INDEX'] || 0)
      @globs = []
      @files = []
      @url = ENV['KINKOU_URL']

      @execution_times = Hash.new(0)
    end

    def expand_globs
      @files = @globs.flat_map { |e| Dir[e] }.map { |e| File.expand_path e }.uniq.sort
    end
  end
end
