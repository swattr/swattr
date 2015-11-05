module Swattr
  class TagsController < ApplicationController
    before_action :set_tag, only: [:show, :new, :edit, :update, :destroy]

    def index
      @tags = Swattr::Tag.all

      authorize @tags

      respond_with @tags
    end

    def show
      respond_with @tag
    end

    def new
      respond_with @tag
    end

    def edit
      respond_with @tag
    end

    def create
      @tag = Swattr::Tag.new(tag_params)

      authorize @tag

      @tag.save

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
      if action_name.to_sym == :new
        @tag = Swattr::Tag.new
      else
        @tag = Swattr::Tag.find(params[:id])
      end

      authorize @tag
    end

    def tag_params
      params.require(:tag).permit(permitted_attributes)
    end
  end
end
