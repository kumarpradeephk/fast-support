class Api::V1::AuthController < Api::V1::BaseController
  skip_before_action :requires_login
  
  def signup
    @user = User.new(auth_params)
    render json: {success: false, messages: @user.errors.message}, status: 422 and return unless @user.save
    @user.send_otp
    render json: {success: true, messages: "signup success and otp sended", phone: @user.phone}, status: :ok and return
  end

  def login
    @user = User.find_by_phone_or_email(params[:login_id])
    render json: {success: false, messages: "Invalid User ID"}, status: 422 and return unless @user
    render json: {success: false, messages: "Invalid password"}, status: 422 and return unless @user.authenticate(params[:password])
  end

  def verify_otp
    @user = User.find_by_phone(params[:phone])
    if @user.authenticate_otp(params[:otp])
      render json: {success: true, messages: "otp verification success"}, status: 200 and return
    else
      render json: {success: false, messages: "Invalid otp"}, status: 422 and return
    end
  end

  def resend_otp
    @user = User.find_by_phone(params[:phone])
    @user.send_otp
    render json: {success: true, messages: "otp sent successfully"}, status: :ok and return
  end

  def forgot_password
    @user = User.find_by_email(params[:email])
    render json: {success: false, messages: "Invalid Email"}, status: 422 and return unless @user
    @user.send_password_on_email
    render json: {success: true, messages: "Please check mail and get password"}, status: :ok and return
  end

  def change_password
    @user = User.find_by_phone_or_email(params[:login_id])
    render json: {success: false, messages: "Invalid Login ID"}, status: 422 and return unless @user
    if @user.authenticate(params[:current_password])
      @user.update(password: params[:new_password])
      render json: {success: true, messages: "password changed successfully"}, status: :ok and return
    else
      render json: {success: false, messages: "password Invalid"}, status: 422 and return
    end
  end

  private

  def auth_params
    params.require(:auth).permit(:firstname, :lastname, :email, :phone, :gender, :password, address_attributes: [:address1, :address2, :landmark, :city, :state, :country, :pincode])
  end

end
