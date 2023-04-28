class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :turbo_frame_request_variant
  rescue_from Pundit::NotAuthorizedError, with: :unauthorized
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    flash[:alert] = 'Resource not found.'
    redirect_to(request.referrer || root_path)
  end

  def unauthorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end

  private

  def turbo_frame_request_variant
    request.variant = :turbo_frame if turbo_frame_request?
  end
end
