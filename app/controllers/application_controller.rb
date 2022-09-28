class ApplicationController < ActionController::API
  include ActionController::Cookies
  rescue_from ActiveRecord::RecordInvalid, with: :record_not_valid_response
  before_action :authorize

  private

  def record_not_valid_response(exception)
    render json: {errors: exception.record.errors.full_messages}, status: 422
  end

  def authorize
    @current_user = User.find_by(id: session[:user_id])
    render json: {errors: ["Not authorized"]}, status: :unauthorized unless @current_user
  end

end
