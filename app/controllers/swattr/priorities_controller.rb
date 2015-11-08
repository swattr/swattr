module Swattr
  class PrioritiesController < ApplicationController
    include Swattr::Concern::Resourceful

    protected

    def permitted_attributes
      [
        :name, :description, :position
      ]
    end
  end
end
