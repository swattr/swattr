module Swattr
  module IssuesHelper
    include HumanBytes

    def filesize_format(file_size = 0, places = 1, i = false)
      HumanBytes.human_bytes(file_size.to_i, places: places, i: i)
    end
  end
end
