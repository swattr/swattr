module Swattr
  module ApplicationHelper
    def date_time_format(timestamp)
      timestamp_format(timestamp, Swattr.configuration.date_time_format)
    end

    def date_format(timestamp)
      timestamp_format(timestamp, Swattr.configuration.date_format)
    end

    def time_format(timestamp)
      timestamp_format(timestamp, Swattr.configuration.time_format)
    end

    def timestamp_format(timestamp, timestamp_format = "%F %H:%M")
      timestamp.to_time.strftime(timestamp_format).squish
    end
  end
end
