module Refinery
  module BackLinks
    module Admin
      class BackLinksController < ::Refinery::AdminController

        crudify :'refinery/back_links/back_link',
                :title_attribute => 'old_link', :xhr_paging => true

        def back_links_list
          respond_to do |format|
            format.csv  { send_data Refinery::BackLinks::BackLink.to_csv }
            format.xls
          end
        end

        def import
          Refinery::BackLinks::BackLink.import(params[:file])
          redirect_to refinery.new_back_links_import_path, :notice => "Back links imported."
        end

      end
    end
  end
end
