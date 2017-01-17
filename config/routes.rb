Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :back_links do
    resources :back_links, :path => '', :only => [:index, :show]
  end

  match '/refinery/back_links/import' => 'back_links/admin/back_links#import', :as => 'admin_import'
  match '/refinery/back_links/new_back_links_import' => 'back_links/admin/back_links#new_back_links_import', :as => 'new_back_links_import'

  # Admin routes
  namespace :back_links, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :back_links, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
