module Refinery
  module BackLinks
    class BackLinksController < ::ApplicationController

      before_filter :find_all_back_links
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @back_link in the line below:
        present(@page)
      end

      def show
        @back_link = BackLink.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @back_link in the line below:
        present(@page)
      end

    protected

      def find_all_back_links
        @back_links = BackLink.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/back_links").first
      end

    end
  end
end
