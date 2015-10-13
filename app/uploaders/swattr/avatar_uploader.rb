module Swattr
  class AvatarUploader < BaseUploader
    def default_url
      ActionController::Base.helpers.asset_path(
        "swattr/fallback/" + [version_name, "avatar.png"].compact.join("_")
      )
    end

    version :medium do
      process resize_to_fit: [300, 300]
    end

    version :thumb do
      process resize_to_fit: [150, 150]
    end

    def filename
      "avatar.#{file.extension}" if original_filename
    end
  end
end
