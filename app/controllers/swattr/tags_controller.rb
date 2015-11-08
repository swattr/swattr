module Swattr
  class TagsController < ApplicationController
    include Swattr::Concern::Resourceful

    protected

    def permitted_attributes
      [
        :name, :description, :color, :position
      ]
    end
  end
end
