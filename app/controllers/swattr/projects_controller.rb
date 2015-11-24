module Swattr
  class ProjectsController < ApplicationController
    before_action :add_project_defaults_on_create, only: [:create]
    before_action :set_project, only: [:show, :new, :edit, :update, :destroy]

    def index
      @q = Swattr::Project.ransack(params[:q].try(:merge, m: "or"))

      @projects = @q.result(distinct: true).page(params[:page]).per(per_page)

      authorize @projects

      respond_with @projects
    end

    def show
      respond_with @project
    end

    def new
      respond_with @project
    end

    def edit
      respond_with @project
    end

    def create
      @project = Swattr::Project.new(project_params)

      authorize @project

      @project.save

      respond_with @project, location: projects_path
    end

    def update
      @project.update(project_params)

      respond_with @project, location: projects_path
    end

    def destroy
      @project.destroy

      respond_with @project, location: projects_path
    end

    protected

    def permitted_attributes
      [
        :name, :slug, :description, :location, :hero, :remove_hero, :author_id
      ]
    end

    def set_project
      if action_name.to_sym == :new
        @project = Swattr::Project.new
      else
        @project = Swattr::Project.find_by(slug: params[:id])
      end

      authorize @project
    end

    def project_params
      params.require(:project).permit(permitted_attributes)
    end

    def add_project_defaults_on_create
      author_id = current_user.id

      params.deep_merge!(project: { author_id: author_id })
    end
  end
end
