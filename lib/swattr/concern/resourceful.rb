module Swattr
  module Concern
    module Resourceful
      extend ActiveSupport::Concern

      included do
        attr_reader :resource, :resources

        before_action :load_resource

        helper_method :resources_path, :resources_url, :new_resource_path,
                      :new_resource_url, :edit_resource_path,
                      :edit_resource_url, :resource_path, :resource_url
      end

      def index
        respond_with @resources
      end

      def show
        respond_with @resource
      end

      def new
        respond_with @resource
      end

      def edit
        respond_with @resource
      end

      def create
        @resource.save

        respond_with @resource, location: -> { location_after_create }
      end

      def update
        @resource.update(resource_params)

        respond_with @resource, location: -> { location_after_update }
      end

      def destroy
        @resource.destroy

        respond_with @resource, location: -> { location_after_destroy }
      end

      protected

      def permitted_attributes
        []
      end

      def location_after_destroy
        resources_url
      end

      def location_after_create
        location_after_save
      end

      def location_after_update
        location_after_save
      end

      def location_after_save
        resources_url
      end

      def load_resource
        # TODO: Less duplication
        if member_action?
          @resource = load_resource_instance

          instance_variable_set("@#{model_name}", @resource)

          # TODO: Make this configurable
          authorize @resource
        else
          # TODO: Make this work with Ransack
          @resources = model_class.where(nil)

          instance_variable_set("@#{controller_name}", @resources)

          # TODO: Make this configurable
          authorize @resources
        end
      end

      def load_resource_instance
        if new_actions.include?(action)
          build_resource
        elsif params[:id]
          find_resource
        end
      end

      def find_resource
        # TODO: Configurable find by
        model_class.find(params[:id])
      end

      def build_resource
        if params[resource_name].present?
          model_class.new(resource_params)
        else
          model_class.new
        end
      end

      def resource_params
        params.require(resource_name).permit(permitted_attributes)
      end

      def action
        action_name.to_sym
      end

      def resource_name
        model_name
      end

      def model_name
        controller_name.singularize
      end

      def model_class
        "swattr/#{model_name}".classify.constantize
      end

      def member_action?
        !collection_actions.include?(action)
      end

      def collection_actions
        [:index]
      end

      def new_actions
        [:new, :create]
      end

      def resources_path(options = {})
        swattr.polymorphic_path([controller_name], options)
      end

      def resources_url(options = {})
        swattr.polymorphic_url([controller_name], options)
      end

      def resource_path(resource, options = {})
        swattr.polymorphic_path([resource], options)
      end

      def resource_url(resource, options = {})
        swattr.polymorphic_url([resource], options)
      end

      def new_resource_path(options = {})
        swattr.new_polymorphic_path([model_name], options)
      end

      def new_resource_url(options = {})
        swattr.new_polymorphic_url([model_name], options)
      end

      def edit_resource_path(resource, options = {})
        swattr.polymorphic_path([resource, :edit], options)
      end

      def edit_resource_url(resource, options = {})
        swattr.polymorphic_url([resource, :edit], options)
      end
    end
  end
end
