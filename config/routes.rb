Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :auth, only: [] do
        collection do
          post "signup"
          post "login"
          post "verify_otp"
          post "resend_otp"
          post "change_password"
          post "forgot_password"
        end
      end
    end
  end

end
