class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordNotUnique, with: :record_duplicate

  def render_not_found
    render json: { status: "Record not found"}, status: :not_found
  end

  def render_duplicate_record
    render json: { status: "Record already exists" }, status: :conflict
  end

  def render_success(message)
    render json: { status: "Success", message: message }, status: :ok
  end

  def render_error(message)
    render json: { status: "Error", message: message }, status: :unprocessable_entity
  end

end
