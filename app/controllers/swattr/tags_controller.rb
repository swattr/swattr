module Swattr
  class TagsController < ApplicationController
    before_action :set_tag, only: [:show, :edit, :update, :destroy]

    def index
      @tags = Swattr::Tag.all

      respond_with @tags
    end

    def show
      respond_with @tag
    end

    def new
      @tag = Swattr::Tag.new

      respond_with @tag
    end

    def edit
      respond_with @tag
    end

    def create
      @tag = Swattr::Tag.create(tag_params)

      respond_with @tag, location: -> { tag_path(@tag) }
    end

    def update
      @tag.update(tag_params)

      respond_with @tag, location: -> { tag_path(@tag) }
    end

    def destroy
      @tag.destroy

      respond_with @tag, location: -> { tags_path }
    end

    protected

    def permitted_attributes
      [
        :name, :description, :color, :position
      ]
    end

    def set_tag
      @tag = Swattr::Tag.find(params[:id])
    end

    def tag_params
      params.require(:tag).permit(permitted_attributes)
    end
  end
end
