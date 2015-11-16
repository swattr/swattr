module Swattr
  class ProjectsController < ApplicationController
    include Swattr::Concern::Resourceful

    def find_by
      :slug
    end

    before_action :add_project_defaults_on_create, only: [:create]

    def index
      @q = Swattr::Project.ransack(params[:q].try(:merge, m: "or"))

      @projects = @q.result(distinct: true).page(params[:page]).per(per_page)

      authorize @projects

      respond_with @projects
    end

    protected

    def permitted_attributes
      [
        :name, :slug, :description, :location, :hero, :remove_hero, :author_id
      ]
    end

    def add_project_defaults_on_create
      author_id = current_user.id

      params.deep_merge!(project: { author_id: author_id })
    end
  end
end
