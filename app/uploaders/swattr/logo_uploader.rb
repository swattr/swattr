module Swattr
  class LogoUploader < BaseUploader
    def default_path
      "swattr/fallback/" + [version_name, "logo.jpg"].compact.join("_")
    end

    process resize_to_fit: [300, 300]

    version :thumb do
      process resize_to_fit: [150, 150]
    end

    def filename
      "logo.#{file.extension}" if original_filename
    end
  end
end
