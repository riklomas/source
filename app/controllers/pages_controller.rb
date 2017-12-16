class PagesController < ApplicationController
  
  def home
    if is_logged_in?
      redirect_to items_path
    end    
  end  
  
end
