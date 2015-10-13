module Swattr
  class HeroUploader < BaseUploader
    def default_url
      ActionController::Base.helpers.asset_path(
        "swattr/fallback/" + [version_name, "hero.jpg"].compact.join("_")
      )
    end

    version :thumb do
      process resize_to_fit: [150, 150]
    end

    def filename
      "hero.#{file.extension}" if original_filename
    end
  end
end
