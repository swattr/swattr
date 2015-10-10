module Swattr
  class Configuration
    DEFAULT_VALUE = nil

    attr_accessor :application, :date_time_format, :date_format, :per_page,
                  :time_format

    def initialize
      @application = "swattr"
      @date_time_format = "%B %e, %Y %l:%M %p"
      @date_format = "%B %e, %Y"
      @per_page = 24
      @time_format = "%l:%M %p"
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
