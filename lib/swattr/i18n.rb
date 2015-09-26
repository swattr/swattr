require "i18n"
require "active_support/core_ext/array/extract_options"

module Swattr
  extend ActionView::Helpers::TranslationHelper

  class << self
    def translate(*args)
      options = args.extract_options!
      options[:scope] = [*options[:scope]].unshift(:swattr)
      args << options

      super *args
    end
    alias_method :t, :translate
  end
end
