require "swattr/engine"
require "swattr/configuration"
require "swattr/i18n"

module Swattr
  class << self
    attr_accessor :configuration

    def configure
      yield configuration
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end
end
