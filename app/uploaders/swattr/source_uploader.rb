require "carrierwave/processing/mime_types"

module Swattr
  class SourceUploader < BaseUploader
    include CarrierWave::MimeTypes

    def extension_white_list
      Swattr.configuration.attachment_white_list
    end

    process :save_attributes

    version :medium, if: :image? do
      process resize_to_fit: [300, 300]
    end

    version :thumb, if: :image? do
      process resize_to_fit: [150, 150]
    end

    def default_path
      "swattr/fallback/" + [version_name, "source.gif"].compact.join("_")
    end

    def type_url
      type = model.content_type

      if known_image_formats.include?(type)
        model.source.versions[version_name].url
      elsif known_formats.include?(type)
        format_path("#{type.parameterize}.png")
      else
        format_path("unknown.png")
      end
    end

    def image?(new_file)
      known_image_formats.include?(new_file.content_type)
    end

    def filename
      "#{secure_token}.#{file.extension}" if original_filename
    end

    protected

    def save_attributes
      model.content_type = file.content_type if file.content_type
      model.file_size = file.size
    end

    def secure_token(length = 16)
      var = :"@#{mounted_as}_secure_token"

      model.instance_variable_get(var) ||
        model.instance_variable_set(var, SecureRandom.hex(length / 2))
    end

    def format_path(asset)
      "swattr/fallback/mime/" + [version_name, asset].compact.join("_")
    end

    def known_image_formats
      [
        "image/jpg", "image/jpeg", "image/png", "image/gif"
      ]
    end

    def known_formats
      [
        "application/pdf"
      ]
    end
  end
end
