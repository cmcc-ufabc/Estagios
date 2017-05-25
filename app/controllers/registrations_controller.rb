class RegistrationsController < Devise::RegistrationsController
  protected

      def confirm
        
      end 
      
      def after_sign_up_path_for(resource)
        "/estagios"
        @tst=Usuario.find(:last)
        if @tst.tipo == 'Servidor (CMCC)' or 'Servidor (CCNH)'
        UserMailer.novo_orientador(@tst.id).deliver 
        flash[:notice] = t(:confirma)
        "/estagios"
        else
          "/estagios"
        end
      
      end 
      
       def after_inactive_sign_up_path_for(resource)
        "/estagios/confirm" 
      end 
end
