module Swattr
  class ProjectsController < ApplicationController
    before_action :set_project, only: [:show, :edit, :update, :destroy]

    def index
      @q = Swattr::Project.ransack(params[:q].try(:merge, m: "or"))

      @projects = @q.result(distinct: true).page(params[:page]).per(per_page)

      respond_with @projects
    end

    def show
      respond_with @project
    end

    def new
      @project = Swattr::Project.new

      respond_with @project
    end

    def edit
      respond_with @project
    end

    def create
      @project = Swattr::Project.create(project_params)

      respond_with @project, location: -> { project_path(@project) }
    end

    def update
      @project.update(project_params)

      respond_with @project, location: -> { project_path(@project) }
    end

    def destroy
      @project.destroy

      respond_with @project, location: -> { projects_path }
    end

    protected

    def permitted_attributes
      [
        :name, :slug, :description, :location, :author_id, :owner_id
      ]
    end

    def set_project
      @project = Swattr::Project.find_by(slug: params[:id])
    end

    def project_params
      params.require(:project).permit(permitted_attributes)
    end
  end
end
