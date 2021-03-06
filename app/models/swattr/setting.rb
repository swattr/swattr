module Swattr
  class Setting < ActiveRecord::Base
    # Uploader
    mount_uploader :logo, Swattr::LogoUploader

    # Validation
    validates :title, presence: true
    validates :per_page, numericality: { only_integer: true,
                                         greater_than: 0,
                                         less_than_or_equal_to: 500 }

    # Scope
    def self.settings
      first_or_create do |setting|
        setting.title = Swattr.t(:swattr)
        setting.per_page = Swattr.configuration.per_page
      end
    end
  end
end
