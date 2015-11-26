require 'json'
require 'httpclient'
require 'kintou/version'
require 'kintou/tracker'
require 'kintou/configuration'

module Kintou
  def self.bind
    Kintou::Tracker.bind
  end

  def self.configure
    yield config
  end

  def self.config
    Configuration.instance
  end
end
