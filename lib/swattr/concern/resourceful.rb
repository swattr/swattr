module Swattr
  module Concern
    module Resourceful
      extend ActiveSupport::Concern

      included do
        attr_reader :resource, :resources
        attr_accessor :find_by, :authorization, :searchable, :paginatable,
                      :search_param, :ransack_merge, :ransack_distinct,
                      :pagination_param, :pagination_per

        before_action :load_resource

        helper_method :resources_path, :resources_url, :new_resource_path,
                      :new_resource_url, :edit_resource_path,
                      :edit_resource_url, :resource_path, :resource_url

        def find_by
          @find_by ||= :id
        end

        def authorization
          @authorization ||= true
        end
        alias :authorization? :authorization

        def searchable
          @searchable ||= false
        end
        alias :searchable? :searchable

        def paginatable
          @paginatable ||= false
        end
        alias :paginatable? :paginatable

        def search_param
          @search_param ||= :q
        end

        def ransack_merge
          @ransack_merge ||= "or"
        end

        def ransack_distinct
          @ransack_distinct ||= true
        end
        alias :ransack_distinct? :ransack_distinct

        def pagination_param
          @pagination_param ||= :page
        end

        def pagination_per
          @pagination_per ||= 24
        end
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

        respond_with @resource, location: location_after_create,
                                action: action_after_failed_create
      end

      def update
        @resource.update(resource_params)

        respond_with @resource, location: location_after_update,
                                action: action_after_failed_update
      end

      def destroy
        @resource.destroy

        respond_with @resource, location: location_after_destroy
      end

      protected

      def permitted_attributes
        []
      end

      def action_after_failed_create
        :new
      end

      def action_after_failed_update
        :edit
      end

      def location_after_save
        resources_url
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

      def load_resource
        if member_action?
          set_resource_instance("resource", model_name, load_resource_instance)

          authorize(@resource) if authorization?
        else
          load_resources
        end
      end

      def load_resources
        if searchable?
          ransack_params = params[search_param].try(:merge, m: ransack_merge)

          query = model_class.ransack(ransack_params)
                             .result(distinct: ransack_distinct)
        else
          query = model_class.where(nil)
        end

        if paginatable?
          query = query.page(params[pagination_param]).per(pagination_per)
        end

        set_resource_instance("resources", controller_name, query)

        authorize(@resources) if authorization?
      end

      def set_resource_instance(local_resource, controller_resource, value)
        instance_variable_set("@#{local_resource}", value)
        instance_variable_set("@#{controller_resource}", value)
      end

      def load_resource_instance
        if new_action?
          build_resource
        elsif params[:id]
          find_resource
        end
      end

      def find_resource
        model_class.find_by("#{find_by}": params[:id])
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

      def new_action?
        new_actions.include?(action)
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
        swattr.edit_polymorphic_path([resource], options)
      end

      def edit_resource_url(resource, options = {})
        swattr.edit_polymorphic_url([resource], options)
      end
    end
  end
end
