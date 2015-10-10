module Swattr
  class Configuration
    DEFAULT_VALUE = nil

    attr_accessor :application, :per_page

    def initialize
      @application = "swattr"
      @per_page = 24
    end

    def method_missing(method_name, *args)
      super(method_name, *args)
    rescue NoMethodError
      method = method_name.to_s

      if method[-1] == "?"
        column = method.sub("?", "")

        send(column.to_sym, *args) != DEFAULT_VALUE
      else
        DEFAULT_VALUE
      end
    end
  end
end
