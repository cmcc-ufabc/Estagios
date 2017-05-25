class RegistrationsController < Devise::RegistrationsController
  protected

      def confirm
        
      end 
      
      def after_sign_up_path_for(resource)
        "/estagios"
      end 
      
       def after_inactive_sign_up_path_for(resource)
        "/estagios/confirm" 
      end 
end