ActiveAdmin.register Item do

  permit_params :title, :description, :image, category_ids: []
  
  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :image
      f.input :categories, as: :check_boxes, collection: Category.order("title asc")
    end
    
    f.actions
  end


end
