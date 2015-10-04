module Swattr
  class AvatarUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    def default_url
      ActionController::Base.helpers.asset_path(
        "swattr/fallback/" + [version_name, "avatar.png"].compact.join("_")
      )
    end

    # process convert: "png"

    version :medium do
      process resize_to_fit: [300, 300]
    end

    version :thumb do
      process resize_to_fit: [150, 150]
    end

    def extension_white_list
      %w(jpg jpeg gif png)
    end

    def filename
      "avatar.#{file.extension}" if original_filename
    end
  end
end
