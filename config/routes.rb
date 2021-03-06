Estagio::Application.routes.draw do






  

  

scope 'estagios/' do

resources :cancelamentos
resources :aprovas
resources :docentes
resources :fluxomatriculas
      
    devise_for :usuarios, :controllers => { :registrations => "registrations" } do
    get 'logout' => 'sessions#destroy', :as => :destroy_user_session
    get 'login' => 'devise/sessions#new'
  end
      match 'home', :controller => 'avisos', :action => 'home'
      match'/confirm', :controller => 'avisos', :action => 'confirm'

    
      match '/cadastro', :controller => 'matriculas', :action => 'cadastro'
      match '/cadastro/create', :controller => 'matriculas', :action => 'create'
      match '/cadastro/filtro', :controller => 'matriculas', :action => 'filtro'
    
      match '/email/matriculas', :controller => 'matriculas', :action => 'email_matriculas'
      
      match '/matriculas/detalhes/:id', :controller => 'matriculas', :action => 'detalhes'
      match '/matriculas/analise/:id', :controller => 'matriculas', :action => 'analise'
      match '/matriculas/anexo/:id', :controller => 'matriculas', :action => 'anexo'
      match '/matriculas/download/:id', :controller => 'matriculas', :action => 'download'
      
      match '/delete/disciplina/', :controller => 'disciplinas', :action => 'delete'
      match 'delete/aviso', :controller => 'avisos', :action => 'delete'
      match 'delete/periodo', :controller => 'periodos', :action => 'delete'
      
      match 'users/', :controller => 'users', :action => 'index'
      match 'users/edit', :controller => 'users', :action => 'edit'
      match 'users/update/:id', :controller => 'users', :action => 'update'
      match 'user/:id', :controller => 'users', :action => 'show'
      match '/teste',:controller => 'conceitos', :action => 'dssi.xls',:format => 'xls'
      match "relatorios/", :controller => 'relatorios', :action => 'index'
      match "relatorios/show/:id", :controller => 'relatorios', :action => 'show'
      match "relatorios/view/:periodo/:curso/:codigo", :controller => 'relatorios', :action => 'view', :format => 'pdf'
      match "relatorios/envio/:periodo/:curso/:codigo", :controller => 'relatorios', :action => 'envio'
      match "relatorios/detalhes/:periodo/:aluno_id/", :controller => 'relatorios', :action => 'detalhes'
      match '/testando',:controller=>'relatorios',:action=>'geral',:format=>'pdf'
      match "/cancelamento", :controller => 'cancelamentos', :action => 'inicio'
      match "/cancelamentos/new", :controller => 'cancelamentos', :action => 'show'
	  match "/cancelamentos/testo/:id", :controller=>'cancelamentos', :action=>'edit'
      match "conceitos/", :controller => 'conceitos', :action => 'index'
      match "conceitos/show/:id", :controller => 'conceitos', :action => 'show'
      match "conceitos/envio/:id", :controller => 'conceitos', :action => 'envio'
      match "conceitos/modelo/:curso/:periodo", :controller => 'conceitos', :action => 'modelo_email'      
      match "conceitos/dssi/:periodo/:ci.xls", :controller => 'conceitos', :action => 'dssi', :format => 'xls'
      match "conceitos/relatorio/:curso/:periodo", :controller => 'conceitos', :action => 'relatorio', :format => 'pdf'
      match "te",:controller => 'relatorios', :action => 'geral', :format => 'pdf'
	  match "/aprova", :controller => 'aprovas', :action=> 'index'
      match "/aprova/edit/:id", :controller => 'aprovas', :action=> 'edit'
      match "/aprova/new/:id", :controller => 'aprovas', :action=> 'new'
      
      match "/unificado/envio2/:id",:controller => 'relatorios', :action => 'envio2'
      match "/unificado/:centro/:id",:controller => 'relatorios', :action => 'unificado',:format=>'pdf'
	  
	  match "/dssirelatorio",:controller=>'dssirelatorios',:action=>'index'
      match "/dssirelatorios/:id", :controller=>'dssirelatorios',:action=>'show'
      match "/enviados/:id/:ci", :controller=>'dssirelatorios',:action=>'enviados',:format=>'pdf'
      
      match "/matricula/individual",:controller=>'matriculas',:action=>'individual'
      match "/matricula/individual/relindiv/:id",:controller=>'matriculas',:action=>'relindiv',:format=>'pdf'
      
      match "/docentes",:controller=>'docentes',:action=>'index'
	  
	  match "/fluxo",:controller=>'fluxomatriculas', :action=>'selecionadata'
      match "/fluxo/:periodo_id",:controller=>'fluxomatriculas', :action=>'selecionaaluno'
      match "/fluxo/:periodo_id/:aluno_id",:controller=>'fluxomatriculas', :action=>'fluxo',:format=>'pdf'
      # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  

    	resources :cancelamentos
      resources :disciplinas
      resources :matriculas
      resources :periodos
	  
      
  root :to => 'avisos#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
   #match ':controller(/:action(/:id))(.:format)'
    
   resources :avisos
    
  end

end
