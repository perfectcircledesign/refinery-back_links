module Refinery
  module BackLinks
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::BackLinks

      engine_name :refinery_back_links

      initializer "register refinerycms_back_links plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "back_links"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.back_links_admin_back_links_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/back_links/back_link',
            :title => 'old_link'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::BackLinks)
      end
    end
  end
end
