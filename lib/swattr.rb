require "carrierwave"
require "date_validator"
require "devise"
require "devise_invitable"
require "kaminari"
require "local_time"
require "mini_magick"
require "paranoia"
require "pundit"
require "ransack"
require "responders"
require "simple_form"
require "validates"

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
