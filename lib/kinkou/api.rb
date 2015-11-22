require 'json'
require 'httpclient'

module Kinkou
  module API
    def self.builds(config)
      payload = {
        name:       config.name,
        session:    config.session,
        node_total: config.node_total,
        node_index: config.node_index,
        files:      config.files,
      }
      response = HTTPClient.new.post 'http://localhost:9292/builds', JSON.dump(payload), 'Content-Type' => 'application/json'
      files = nil
      if response.ok?
        files = JSON.parse(response.body)['files']
      else
        files = payload[:files].each_slice(payload[:node_total]).map { |e| e[payload[:node_index]] }.compact
      end
      files
    end

    def self.results(config)
      payload = {
        name:    config.name,
        session: config.session,
        files:   config.execution_times
      }
      HTTPClient.new.post 'http://localhost:9292/results', JSON.dump(payload), 'Content-Type' => 'application/json'
    end
  end
end
