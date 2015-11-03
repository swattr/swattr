module Swattr
  class SourceUploader < BaseUploader
    IMAGE_EXTENSIONS = %w(jpg jpeg gif png)
    DOCUMENT_EXTENSIONS = %w(pdf doc docx txt)

    def extension_white_list
      IMAGE_EXTENSIONS + DOCUMENT_EXTENSIONS
    end

    def default_path
      "swattr/fallback/" + [version_name, "source.gif"].compact.join("_")
    end

    version :medium, if: :image? do
      process resize_to_fit: [300, 300]
    end

    version :thumb, if: :image? do
      process resize_to_fit: [150, 150]
    end

    def image?(new_file)
      new_file.content_type.start_with? "image"
    end

    def filename
      "#{secure_token}.#{file.extension}" if original_filename
    end

    protected

    def secure_token(length=16)
      var = :"@#{mounted_as}_secure_token"

      model.instance_variable_get(var) ||
      model.instance_variable_set(var, SecureRandom.hex(length/2))
    end
  end
end
