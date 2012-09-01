class ItemsController < ApplicationController
    before_filter :check_login
    before_filter :check_style
    before_filter :check_notification
    
    def show
        @item = Item.find(params[:id])
    end
end
