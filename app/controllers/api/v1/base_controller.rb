class Api::V1::BaseController < ApplicationController
  before_action :set_current_user
  before_action :requires_login

  attr_reader :current_user
  helper_method :current_user

  protected
  
  def requires_login
    return if current_user_present?
    render json: { meta: {status: false, message: "No logged in user"} }, status: 401
  end

  def current_user_present?
    current_user.present?
  end

  def set_current_user
    begin
      token = request.header["Authorization"].to_s[6..-1]
      return unless token
      @current_user = User.find_by(auth_token: token)
    rescue Exception => e
      return render json: { error: e.message }, status: :unprocessable_entity
    end
  end
end