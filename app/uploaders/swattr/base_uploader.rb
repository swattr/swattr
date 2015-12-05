module Swattr
  class BaseUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    def default_url
      ActionController::Base.helpers.asset_path(default_path)
    end

    def default_path
      "swattr/fallback/" + [version_name, "default.png"].compact.join("_")
    end

    def extension_white_list
      %w(jpg jpeg gif png)
    end

    def remove_animation
      manipulate!(&:collapse!) if content_type == "image/gif"
    end
  end
end
