class ItemsController < ApplicationController
  
  before_action :force_login
  
  def index
    # if there's a search, filter!!!
    # if not, show all!
    
    if params[:q].present?
      # this is where we search!
      @items = Item.where("lower(title) LIKE ?", "%" + params[:q].downcase + "%")
    else
      # show all
      @items = Item.all
    end
  end
  
  def show
    @item = Item.find(params[:id])
  end
  
end
