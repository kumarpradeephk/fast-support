class Api::V1::AuthController < Api::V1::BaseController
  skip_before_action :requires_login
  
  def signup
    
  end

  def login
    
  end

  def verify_otp
    
  end

  def resend_otp
    
  end

  def forgot_password
    
  end

  def reset_password
    
  end

  private

  def signup_params
    auth_params.except(:address_attributes)
  end

  def auth_params
    params.require(:auth).permit(:firstname, :lastname, :email, :phone, :gender, :password, address_attributes: [:address1, :address2, :landmark, :city, :state, :country, :pincode])
  end

end
