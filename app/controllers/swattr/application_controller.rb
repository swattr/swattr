require "swattr/application_responder"

module Swattr
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    include Pundit

    before_action :authenticate_user!

    layout :set_layout

    respond_to :html, :json
    responders :flash, :http_cache

    rescue_from Exception, with: :render_500
    rescue_from ActionController::UnknownController,
                ::AbstractController::ActionNotFound,
                ActiveRecord::RecordNotFound, with: :render_404
    rescue_from ActionController::RoutingError,
                Pundit::NotAuthorizedError, with: :render_401

    protected

    def set_layout
      "swattr/layouts/application"
    end

    def render_401(exception)
      render_error("swattr/errors/error_401", 401, exception)
    end

    def render_404(exception)
      render_error("swattr/errors/error_404", 404, exception)
    end

    def render_500(exception)
      render_error("swattr/errors/error_500", 500, exception)
    end

    def render_error(path, status, exception)
      log_error(exception)

      render(template: path, status: status)
    end

    def log_error(exception)
      Rails.logger.error status.to_s + " " + exception.message.to_s
      Rails.logger.error exception.backtrace.join("\n")
    end
  end
end
